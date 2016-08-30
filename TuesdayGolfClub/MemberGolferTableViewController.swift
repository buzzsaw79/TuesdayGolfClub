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
    
    //MARK: -
    //MARK: IBActions
    
    @IBAction func addGolfer(sender: UIBarButtonItem) {
        // Create AlertController
        let alert = UIAlertController(title: "Add Golfer", message: nil, preferredStyle: .Alert)
        // Add Textfield to Alert
        alert.addTextFieldWithConfigurationHandler { (golferName) -> Void in
            golferName.placeholder = "Enter Golfer Name"
        }
        // the add action for the textfield
        let addAction = UIAlertAction(title: "Add", style: .Default) { _ in
            let entity = NSEntityDescription.entityForName("Golfer", inManagedObjectContext: self.context)
            let golfer = Golfer(entity: entity!, insertIntoManagedObjectContext: self.context)
            let textField = alert.textFields?.first
            golfer.name = textField?.text
            
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
        let fetchGolferSort = NSSortDescriptor(key: "name", ascending: true)
        fetchGolferRequest.sortDescriptors = [fetchGolferSort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchGolferRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Unable to perform Golfer fetch: \(error.localizedDescription)")
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCellWithIdentifier("golferCell")!

//         Configure the cell...
        cell.textLabel?.text = golfer.name

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
