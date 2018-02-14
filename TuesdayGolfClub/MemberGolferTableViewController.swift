//
//  MemberGolferTableViewController.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 30/08/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import UIKit
import CoreData

class MemberGolferTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    //MARK: -
    //MARK: Properties
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }()
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    var fetchRequest: NSFetchRequest<NSFetchRequestResult>?
    
    var players = [Golfer]()
    
    var tournee: Tournee!
    
    //MARK: -
    //MARK: IBActions
    @IBAction func startTournee(_ sender: UIBarButtonItem) {
        
        // Create new Tournee
        self.tournee = Tournee.createAndSaveTournee(with: self.players, inManagedObjectContext: self.context)

        performSegue(withIdentifier: "getPlayers", sender: self.tournee)
        
        // DEBUG
        // printTournees()
        //        printGolfersAndPlayers()
      
    }
    

    
    //MARK: -
    //MARK: View Conroller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchGolferRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.golferEntityString)
        let fetchGolferSort = NSSortDescriptor(key: "clubHandicap", ascending: true)
        fetchGolferRequest.sortDescriptors = [fetchGolferSort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchGolferRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Unable to perform Golfer fetch: \(error.localizedDescription)")
        }
        
        // registering cell nib
        let memTVCNib = UINib(nibName: "MemberTableViewCell", bundle: nil)
        tableView.register(memTVCNib, forCellReuseIdentifier: "golferCell")
        
        fetchRequest = fetchGolferRequest
        
        // DEBUG
        //        printGolfersAndPlayers()
//                printTournees()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    //MARK: -
    //MARK: FetchedResultController Delegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sectionCount = fetchedResultsController.sections?.count else {
            return 0
        }
        return sectionCount
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = fetchedResultsController.sections?[section] else {
            return 0
        }
        return sectionData.numberOfObjects
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get Golfer object
        let golfer = fetchedResultsController.object(at: indexPath) as! Golfer
        let cell:MemberTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "golferCell", for: indexPath) as! MemberTableViewCell
        
        //Configure the cell...
        cell.memberNamelabel?.text = golfer.name
        cell.memberHandicapLabel?.text = String(describing: golfer.clubHandicap ?? 0.0)
        cell.memberImage.image = UIImage(data: golfer.image! as Data)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let golfer = fetchedResultsController.object(at: indexPath) as! Golfer
        players.append(golfer)
        
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        cell.textLabel?.textColor = UIColor.red
        cell.setNeedsDisplay()
        
        let golfer = fetchedResultsController.object(at: indexPath) as! Golfer
        
        let index = players.index(of: golfer)
        players.remove(at: index!)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            let golfer = fetchedResultsController.object(at: indexPath) as! Golfer
            context.delete(golfer)
            do {
                try context.save()
            } catch let error as NSError {
                print("Error saving context after delete! \(error.localizedDescription)")
            }
        default:
            break
        }
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "getPlayers" {
            
            let playersController = segue.destination as! PlayersTableViewController
            
            do {
                try self.context.save()
            } catch let err as NSError {
                print("CoreData error whilst saving: ERROR:- \(err)")
            }
            
            playersController.playersArray = self.players
            playersController.todaysTournee = self.tournee
            
        } else if segue.identifier == "Add Golfer" {
            
        }
    }
    
    
    //MARK: -
    //MARK: Helper Functions
    
    fileprivate func printGolfersAndPlayers() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Golfer")
        
        context.perform {
            if let results = try? self.context.fetch(request) {
                //DEBUG
                print("\(results.count) Golfers")
                print("in managedObjectContext \(self.context)")
                
                for aGolfer in results {
                    let golfer = aGolfer as! Golfer
                    //DEBUG
                    print("\(golfer.name!) \(golfer.clubHandicap!)")
                    
                }
            }
        }
        
        
    }
    
    fileprivate func printTournees() {
        
        let request = Tournee.tourneeFetchRequest()
        globalInt = 1
        context.perform {
            if let results = try? self.context.fetch(request) {
                // DEBUG
                print("\(results.count) Tournees in managedObjectContext \(self.context)")
                
                
                for aTournee in results {
                    let tournee = aTournee 
                    
                    // DEBUG
//                    print("OOOOOOOOOOOOO -- \(tournee.day!) -- \(tournee.course!) -- \(String(describing: tournee.hasEntrants)) -- OOOOOOOOOOOO")
                    
                    // Delete Tournee's
                    //                    self.context.deleteObject(tournee)
                    //
                    //                    do {
                    //                        try self.context.save()
                    //                    } catch {
                    //                        print("Couldn't save after deleting tournees")
                    //                    }
                    
                    //                    for object  in tournee.hasEntrants!  {
                    //                        if let golfer = object as? Golfer  {
                    //                            // DEBUG
                    //                            print("Golfer in hasEntrants \(golfer)")
                    //                        }
                    //                    }
                    
                }
                
            }
        }
        
        
        
    }
    
    
}
