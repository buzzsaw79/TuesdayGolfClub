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
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }()
    
    var fetchedResultsController: NSFetchedResultsController!
    
    var fetchRequest: NSFetchRequest?
    
    var players = [Golfer]()
    
    //MARK: -
    //MARK: IBActions
    @IBAction func addPlayers(sender: UIBarButtonItem) {
        
        let entity = NSEntityDescription.entityForName("Tournee", inManagedObjectContext: self.context)
        let tournee = Tournee(entity: entity!, insertIntoManagedObjectContext: self.context)
        
        tournee.date = NSDate()
        
        
        do {
            try self.context.save()
        } catch let error as NSError {
            print("Error saving tournee \(error.localizedDescription)")
        }
        
        performSegueWithIdentifier("getPlayers", sender: tournee)
        
        
        
        printGolfersAndPlayers()
    }
    
    @IBAction func addGolfer(sender: UIBarButtonItem) {
        
        // Create AlertController
        let alert = UIAlertController(title: "Add Golfer", message: nil, preferredStyle: .Alert)
        
        // Add Textfield to Alert
        alert.addTextFieldWithConfigurationHandler { (golferName) -> Void in
            
            golferName.placeholder = "Enter Golfer Name"
        }
        
        // Add another Textfield to Alert
        alert.addTextFieldWithConfigurationHandler { (golferHandicap) -> Void in
            golferHandicap.placeholder = "Enter Golfer Handicap"
        }
        // the add action for the textfield
        let addAction = UIAlertAction(title: "Add", style: .Default) { _ in
            let entity = NSEntityDescription.entityForName("Golfer", inManagedObjectContext: self.context)
            let golfer = Golfer(entity: entity!, insertIntoManagedObjectContext: self.context)
            let nameTextField = alert.textFields?.first
            let handicapTextField = alert.textFields?.last
            golfer.name = nameTextField?.text
            
            
            
            golfer.clubHandicap = NSDecimalNumber(string: handicapTextField?.text) ?? 0.0
            golfer.playingHandicap = golfer.clubHandicap?.decimalNumberByRoundingAccordingToBehavior(nil)
            
            
            if let fullName = golfer.name?.componentsSeparatedByString(" ") {
                
                golfer.firstName = fullName.first!
                golfer.surname = fullName.last!
                
            }
            
            
            do {
                try self.context.save()
            } catch let error as NSError {
                print("Error saving golfer \(error.localizedDescription)")
            }
        }
        
        // the cancel action for the textfield
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        // add the actions to the alert
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        // present the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }

    //MARK: -
    //MARK: View Conroller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchGolferRequest = NSFetchRequest(entityName: "Golfer")
        let fetchGolferSort = NSSortDescriptor(key: "surname", ascending: true)
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
        tableView.registerNib(memTVCNib, forCellReuseIdentifier: "golferCell")
        
//        printDatabaseStatistics(fetchGolferRequest)
        
        fetchRequest = fetchGolferRequest
        
        printGolfersAndPlayers()

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.printDatabaseStatistics(self.fetchRequest!)
        
    }
    
    //MARK: -
    //MARK: FetchedResultController Delegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        default:
            break
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
        default:
            break
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let sectionCount = fetchedResultsController.sections?.count else {
            return 0
        }
        return sectionCount
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = fetchedResultsController.sections?[section] else {
            return 0
        }
        return sectionData.numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let golfer = fetchedResultsController.objectAtIndexPath(indexPath) as! Golfer
//        let cell = tableView.dequeueReusableCellWithIdentifier("golferCell")!
        let cell:MemberTableViewCell! = tableView.dequeueReusableCellWithIdentifier("golferCell", forIndexPath: indexPath) as! MemberTableViewCell

//      Configure the cell...
        
        
        cell.memberNamelabel?.text = golfer.name
        cell.memberHandicapLabel?.text = String(golfer.clubHandicap ?? 0.0)
        
        // Alternate rows different background colour
//        if indexPath.row % 2 == 0 {
//            cell.backgroundColor = UIColor.evenCellColour()
//            cell.memberNamelabel.textColor = UIColor.evenCellTextColour()
//        } else {
//            cell.backgroundColor = UIColor.oddCellColour()
//            cell.memberNamelabel.textColor = UIColor.oddCellTextColour()
//        }
        

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        let alert = UIAlertController(title: "Cell Selected", message: "you selected a cell", preferredStyle: .Alert)
//        // the cancel action for the textfield
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//        
//        // add the actions to the alert
//        alert.addAction(cancelAction)
//        self.presentViewController(alert, animated: true, completion: nil)

        let golfer = fetchedResultsController.objectAtIndexPath(indexPath) as! Golfer
        players.append(golfer)

    
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        cell.textLabel?.textColor = UIColor.redColor()
        cell.setNeedsDisplay()
        
        let golfer = fetchedResultsController.objectAtIndexPath(indexPath) as! Golfer

        let index = players.indexOf(golfer)
        players.removeAtIndex(index!)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        switch editingStyle {
        case .Delete:
            let golfer = fetchedResultsController.objectAtIndexPath(indexPath) as! Golfer
            context.deleteObject(golfer)
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "getPlayers" {
        
        let playersController = segue.destinationViewController as! PlayersTableViewController
        // Pass the selected object to the new view controller.
        
            if let tournee = sender as! Tournee? {
                
                
                
            }
        
//        let fetchTourneeRequest = NSFetchRequest(entityName: "Tournee")
//        let fetchTourneeSort = NSSortDescriptor(key: "date", ascending: true)
//        fetchTourneeRequest.sortDescriptors = [fetchTourneeSort]
//        
//        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchTourneeRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//        fetchedResultsController.delegate = self
//        
//        do {
//            try fetchedResultsController.performFetch()
//        } catch let error as NSError {
//            print("Unable to perform Tournee fetch: \(error.localizedDescription)")
//        }
//        
        
        
        
        playersController.playersArray = self.players
            
        }
    }
 
    
    //MARK: -
    //MARK: Helper Functions
    private func printDatabaseStatistics(request: NSFetchRequest) -> [Golfer]? {
        
        var golfers: [Golfer]?
        
        context.performBlock {
            if let results = try? self.context.executeFetchRequest(request) {
                print("\(results.count) Golfers")
                print("in managedObjectContext \(self.context)")
                
                for aGolfer in results {
                    let golfer = aGolfer as! Golfer
                    print("\(golfer.name!) \(golfer.clubHandicap!)")
                    golfers?.append(golfer)
                    
                }
                
                
            }
            
            let tourneeCount = self.context.countForFetchRequest(NSFetchRequest(entityName: "Tournee"), error: nil)
            print("\(tourneeCount) Tournees" )
        }
        
        return golfers
    }
    
    
    private func printGolfersAndPlayers() {
        
        context.performBlock {
            if let results = try? self.context.executeFetchRequest(self.fetchRequest!) {
                print("\(results.count) Golfers")
                print("in managedObjectContext \(self.context)")
                
                for aGolfer in results {
                    let golfer = aGolfer as! Golfer
                    print("\(golfer.name!) \(golfer.clubHandicap!)")
                    
                }
   
            }
        }
        
        print("Players: \(self.players)")
        
    }
    
    
    
    
    
    
    

}
