//
//  PlayersTableViewController.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 02/09/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import UIKit
import CoreData

class PlayersTableViewController: UITableViewController {
    
    //MARK: -
    //MARK: Properties
    var playersArray = [Golfer]()
    
    var groups = [[Golfer]]()
    
    var theGroups = [[Int]]()
    
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }()
    
    
    //MARK: -
    //MARK: View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Playing Groups"
        
        groups = self.randomiseGolfers(playersArray)
//        self.populateGroups(playersArray)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("didSelectRowAtIndexPath")
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return theGroups.count
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
//        print("theGroups[\(section)]: \(theGroups[section].debugDescription)")
        return theGroups[section].count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("playerCell", forIndexPath: indexPath)

        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.evenCellColour()
            cell.textLabel!.textColor = UIColor.evenCellTextColour()
            cell.detailTextLabel!.textColor = UIColor.evenCellTextColour()
        } else {
            cell.backgroundColor = UIColor.oddCellColour()
            cell.textLabel!.textColor = UIColor.oddCellTextColour()
            cell.detailTextLabel!.textColor = UIColor.oddCellTextColour()
        }
        
//        switch indexPath.section {
//        case 0:
//            print("Switch \(indexPath.section)")
//        case 1:
//            print("Switch \(indexPath.section)")
//        case 2:
//            print("Switch \(indexPath.section)")
//        case 3:
//            print("Switch \(indexPath.section)")
//        case 4:
//            print("Switch \(indexPath.section)")
//        case 5:
//            print("Switch \(indexPath.section)")
//        default:
//            print("Switch \(indexPath.section)")
//        }
        
        
        if !playersArray.isEmpty {
            let randomIndex = Int(arc4random_uniform(UInt32(playersArray.count)))
            
            let golfer = groups[indexPath.section][indexPath.row]
            
//            let golfer = playersArray.removeAtIndex(randomIndex)
            cell.textLabel?.text = golfer.name
            cell.detailTextLabel?.text = String(golfer.playingHandicap!)
        }
  
        return cell
    }

    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var headerTitleString = ""
        switch section {
        case 0:
            headerTitleString = "First Group"
        case 1:
            headerTitleString = "Second Group"
        case 2:
            headerTitleString = "Third Group"
        case 3:
            headerTitleString = "Forth Group"
        default:
            headerTitleString = "Another Group"
        }
        
        
        
//        tableView.headerViewForSection(section)?.textLabel?.textColor = UIColor.whiteColor()
        
        return headerTitleString
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
    
    
     // MARK: - Navigation
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "enterScore" {
            if let enterScoreVC = segue.destinationViewController as? EnterScoreViewController {
                
                let playerCell = sender as! UITableViewCell
                
//                let testContext = playersArray.first?.managedObjectContext
                
                let golfer = Golfer.fetchGolferWithName(playerCell.textLabel!.text!, inManagedObjectContext: self.context)
                
//                enterScoreVC.playerName = playerCell.textLabel!.text!
                enterScoreVC.playerName = golfer?.name
                enterScoreVC.players = groups
                
                
                print(playerCell.textLabel!.text!)
                print("golfer \(golfer.debugDescription)")
            }
            
        }
     
        print("PTVC prepareForSegue: \(sender.debugDescription)")
        
     }
    
    @IBAction func back2(segue: UIStoryboardSegue) {
        print("Unwinding")
    }
    
    
    
    //MARK: -
    //MARK: Helper Functions
    
    func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.evenCellColour()
            cell.textLabel!.textColor = UIColor.evenCellTextColour()
            cell.detailTextLabel!.textColor = UIColor.evenCellTextColour()
        } else {
            cell.backgroundColor = UIColor.oddCellColour()
            cell.textLabel!.textColor = UIColor.oddCellTextColour()
            cell.detailTextLabel!.textColor = UIColor.oddCellTextColour()
        }
        
        return cell
        
    }

    func populateGroups(players:[Golfer]) {
        
        switch players.count {
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
    }
    
    

    
    func randomiseGolfers(players:[Golfer]) -> [[Golfer]] {
        
        self.populateGroups(players)
        
        // Copy passed in array to make it mutable
        var golfers = players
        
        // Create empty array of golfer arrays
        var playingGroups = [[Golfer]]()
        
//        var playingGroups = [[Golfer]](count:theGroups.count, repeatedValue:[Golfer](count:Constants.numbers.maxGolfersInGroup,
//            repeatedValue:Golfer()))
        
        
        if !golfers.isEmpty {
            
            for (outerIndex, aGroup) in theGroups.enumerate() {
                
                playingGroups.append([Golfer]())
                
                for (_, _) in aGroup.enumerate() {
                    
                    // get random golfer from array
                    let randomIndex = Int(arc4random_uniform(UInt32(golfers.count)))
                    let golfer = golfers.removeAtIndex(randomIndex)
                    
                    print("randomiseGolfers() -> \(golfer.name)\(golfer.clubHandicap)")
                    
                    // Multi-Dimensional Array Population
                    playingGroups[outerIndex].append(golfer)
                    
                }
            }
            
        }
        
        
        print("🔬 playingGroups: \(playingGroups)")
        return playingGroups
    }
    
    

    
    
}
