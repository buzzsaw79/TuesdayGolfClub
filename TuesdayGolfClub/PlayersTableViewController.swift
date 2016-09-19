//
//  PlayersTableViewController.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 02/09/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import UIKit

class PlayersTableViewController: UITableViewController {
    
    //MARK: -
    //MARK: Properties
    var playersArray = [Golfer]()
    
    var groups = [[Golfer]]()
    
    var theGroups = [[Int]]()
    
    
    //MARK: -
    //MARK: View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Playing Groups"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
//        for player in playersArray {
//            
//        }
        
        
        self.populateGroups()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return theGroups.count
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        print("theGroups[\(section)]: \(theGroups[section].debugDescription)")
        return theGroups[section].count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("playerCell", forIndexPath: indexPath)

        
        switch indexPath.section {
        case 0:
//            print("Switch \(indexPath.section)")
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.oddCellColour()
                cell.textLabel!.textColor = UIColor.oddCellTextColour()
                cell.detailTextLabel!.textColor = UIColor.oddCellTextColour()
            } else {
                cell.backgroundColor = UIColor.evenCellColour()
                cell.textLabel!.textColor = UIColor.evenCellTextColour()
                cell.detailTextLabel!.textColor = UIColor.evenCellTextColour()
            }
        case 1:
//            print("Switch \(indexPath.section)")
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.evenCellColour()
                cell.textLabel!.textColor = UIColor.evenCellTextColour()
                cell.detailTextLabel!.textColor = UIColor.evenCellTextColour()
            } else {
                cell.backgroundColor = UIColor.oddCellColour()
                cell.textLabel!.textColor = UIColor.oddCellTextColour()
                cell.detailTextLabel!.textColor = UIColor.oddCellTextColour()
            }
        case 2:
            print("Switch \(indexPath.section)")
        case 3:
            print("Switch \(indexPath.section)")
        case 4:
            print("Switch \(indexPath.section)")
        case 5:
            print("Switch \(indexPath.section)")
        default:
            print("Switch \(indexPath.section)")
        }
        if !playersArray.isEmpty {
            let randomIndex = Int(arc4random_uniform(UInt32(playersArray.count)))
            let golfer = playersArray.removeAtIndex(randomIndex)
            cell.textLabel?.text = golfer.name
            cell.detailTextLabel?.text = String(golfer.playingHandicap!)
        }
  
        return cell
    }

    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        tableView.headerViewForSection(section)?.textLabel?.textColor = UIColor.whiteColor()
        
        let groupNumberString = String(section+1)
        return "Group \(groupNumberString)"
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let headerView = view as! UITableViewHeaderFooterView
        
        headerView.textLabel?.textAlignment = .Center
        headerView.textLabel?.textColor = UIColor.whiteColor()
        headerView.backgroundView?.backgroundColor = UIColor.headerColour()
        
        
        
//        view.tintColor = UIColor.headerColour()
//        view.textLabel?.textColor = UIColor.whiteColor()
    }
    
   
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
    
    
    //MARK: -
    //MARK: Helper Functions

    func populateGroups() {
        
        switch self.playersArray.count {
        case 4: theGroups = [[1,2],[3,4]]   // 2x2
        case 5: theGroups = [[1,2],[3,4,5]]     // 1x2, 1x3
        case 6: theGroups = [[1,2,3],[4,5,6]]   // 2x3
        case 7: theGroups = [[1,2,3],[4,5,6,7]] // 1x3, 1x4
        case 8: theGroups = [[1,2,3,4],[5,6,7,8]]   // 2x4
        case 9: theGroups = [[1,2,3],[4,5,6],[7,8,9]]   // 3x3
        case 10: theGroups = [[1,2,3],[4,5,6],[7,8,9,10]]   // 2x3, 1x4
        case 11: theGroups = [[1,2,3],[4,5,6,7],[8,9,10,11]] // 1x3, 2x4
        case 12: theGroups = [[1,2,3,4],[5,6,7,8],[9,10,11,12]] // 3x4
        case 13: theGroups = [[1,2,3],[4,5,6],[7,8,9],[10,11,12,13]]    // 3x3, 1x4
        case 14: theGroups = [[1,2,3],[4,5,6],[7,8,9,10],[11,12,13,14]] // 2x3, 2x4
        case 15: theGroups = [[1,2,3],[4,5,6,7],[8,9,10,11],[12,13,14,15]]  // 1x3, 3x4
        case 16: theGroups = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]   // 4x4
        case 17: theGroups = [[1,2,3],[4,5,6],[7,8,9],[10,11,12,13],[14,15,16,17]]// 3x3, 3x4
        case 18: theGroups = [[1,2,3],[4,5,6],[7,8,9,10],[11,12,13,14],[15,16,17,18]]   // 2x3, 3x4
        default: break
        }
        let groupCount = theGroups.count
        
    }
}
