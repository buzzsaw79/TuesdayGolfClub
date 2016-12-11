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
    
    var tournee: Tournee!
    
    //MARK: -
    //MARK: IBActions
    @IBAction func startTournee(sender: UIBarButtonItem) {
        
        // Create new Tournee
        let entity = NSEntityDescription.entityForName(Constants.Entity.tourneeEntityString, inManagedObjectContext: self.context)
        self.tournee = Tournee(entity: entity!, insertIntoManagedObjectContext: self.context)
        
        self.tournee.course = Constants.courses.mack  //"Mackintosh"
        self.tournee.date = NSDate()
        self.tournee.day = NSDate.todayAsString()
        self.tournee.mutableSetValueForKey("hasEntrants").addObjectsFromArray(self.players)
        self.tournee.entryFee = 9
        self.tournee.scores = [:]
        self.tournee.completed = NSNumber(bool: false)
        
        let prizeFundInt = (tournee.hasEntrants?.count)! * Int(self.tournee.entryFee!)
        
        self.tournee.prizeFund = NSDecimalNumber.init(integer: prizeFundInt)
        
        
        // DEBUG
//        print("Tournee ID: \(self.tournee.objectID)")
        
        
        do {
            try self.context.save()
        } catch let error as NSError {
            print("Error saving tournee \(error.localizedDescription)")
        }
        
        performSegueWithIdentifier("getPlayers", sender: self.tournee)
        
        // DEBUG
        //printTournees()
//        printGolfersAndPlayers()
        
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
            let entity = NSEntityDescription.entityForName(Constants.Entity.golferEntityString, inManagedObjectContext: self.context)
            let golfer = Golfer(entity: entity!, insertIntoManagedObjectContext: self.context)
            let nameTextField = alert.textFields?.first
            let handicapTextField = alert.textFields?.last
            golfer.name = nameTextField?.text
            
            
            golfer.membershipNumber = "123456"
            golfer.clubHandicap = NSDecimalNumber(string: handicapTextField?.text) ?? 0.0
            golfer.playingHandicap = golfer.clubHandicap?.decimalNumberByRoundingAccordingToBehavior(nil)
//            golfer.playsInA = Tournee.tourneeContainingGolfer(golfer)
            
            
            
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
        
        let fetchGolferRequest = NSFetchRequest(entityName: Constants.Entity.golferEntityString)
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
        tableView.registerNib(memTVCNib, forCellReuseIdentifier: "golferCell")
        
        fetchRequest = fetchGolferRequest
        
        // DEBUG
//        printGolfersAndPlayers()
//        printTournees()

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
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
        
        // Get Golfer object
        let golfer = fetchedResultsController.objectAtIndexPath(indexPath) as! Golfer
        let cell:MemberTableViewCell! = tableView.dequeueReusableCellWithIdentifier("golferCell", forIndexPath: indexPath) as! MemberTableViewCell

        //Configure the cell...
        cell.memberNamelabel?.text = golfer.name
        cell.memberHandicapLabel?.text = String(golfer.clubHandicap ?? 0.0)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "getPlayers" {
            
            let playersController = segue.destinationViewController as! PlayersTableViewController
            
            do {
                try self.context.save()
            } catch let err as NSError {
                print("CoreData error whilst saving: ERROR:- \(err)")
            }
            
            playersController.playersArray = self.players
            playersController.todaysTournee = self.tournee
            
        }
    }
 
    
    //MARK: -
    //MARK: Helper Functions
    
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
        
        
    }
    
    private func printTournees() {
        
        let request = NSFetchRequest(entityName: "Tournee")
        
        context.performBlock {
            if let results = try? self.context.executeFetchRequest(request) {
                // DEBUG
                print("\(results.count) Tournees in managedObjectContext \(self.context)")
                
                
                for aTournee in results {
                    let tournee = aTournee as! Tournee
                    
                    // DEBUG
                    print("\(tournee.day!) \(tournee.course!) \(tournee.hasEntrants)")

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
