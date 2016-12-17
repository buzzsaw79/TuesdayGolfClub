//
//  EnterScoreViewController.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 19/09/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import UIKit
import CoreData

protocol handleScoreDataDelegate {
    func saveScores()
}


class EnterScoreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
    
    //MARK: -
    //MARK: Properties
    
    var playerName: String?
    var players = [[Golfer]]()
    // Temp score holder
    var playersScores = [String:Int]()
    
    
    @IBOutlet weak var enterScoreCollectionView: UICollectionView!
    
    @IBAction func saveButton() {
        let sortedByPlayersScoreArray = playersScores.sort { $0.1 > $1.1 }
        
        
        
        // DEBUG
        print("Save button pressed!")
        print("🏁 sortedByPlayersScoreArray 🏁 -> \(sortedByPlayersScoreArray)")
    }
    
    
    
    //MARK: -
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterScoreCollectionView.delegate = self
        enterScoreCollectionView.dataSource = self
        
        navigationController?.delegate = self
        // DEBUG
//        print("#### enterScoreVC Players array:\(players)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -
    //MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return players.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = enterScoreCollectionView.dequeueReusableCellWithReuseIdentifier(Constants.Storyboard.EnterScoreCellIdentifier, forIndexPath: indexPath) as! EnterScoreCollectionViewCell
        
        
        cell.golfer = self.players[indexPath.section][indexPath.row]
        
        cell.playerNameLabel.text = cell.golfer!.firstName
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "EnterScoreHeaderView", forIndexPath: indexPath) as! EnterScoreHeaderView
        
        
        var headerTitleString = ""
        switch indexPath.section {
        case 0:
            headerTitleString = "First Group"
        case 1:
            headerTitleString = "Second Group"
        case 2:
            headerTitleString = "Third Group"
        case 3:
            headerTitleString = "Forth Group"
        default:
            headerTitleString = "\(indexPath.section+1)th Group"
        }
        
        
        headerView.sectionHeaderTitle.text = headerTitleString
        
        return headerView
    }
    
    //MARK: -
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerSizeWidth = self.view.bounds.width
        let headerSizeHeight = CGFloat(48)
        return CGSizeMake(headerSizeWidth, headerSizeHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let aSize = (self.view.bounds.width - 32.0)/3
        let cellSize = CGSizeMake(aSize, aSize)
        return cellSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 8.0
    }
    
    var CVCCount = 0
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        CVCCount = CVCCount + 1
        
        // DEBUG
        //print("\(CVCCount)About to display EnterScoreCollectionViewCell: \(cell)")
    }
    
    // MARK:
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "back2" {
            // Triggered by Unwind segue when "Save" button clicked
            let playersVC = segue.destinationViewController as! PlayersTableViewController
            
            let numberOfSections = enterScoreCollectionView.numberOfSections()
            for section in 1...numberOfSections {
                let sectionIndex = section - 1
                
                for item in 1...enterScoreCollectionView.numberOfItemsInSection(sectionIndex) {
                    let cellIndex = item - 1
                    let cellIndexPath = NSIndexPath(forItem: cellIndex, inSection: sectionIndex)
                    let cell = enterScoreCollectionView.cellForItemAtIndexPath(cellIndexPath) as! EnterScoreCollectionViewCell
                    
                    // Get score data from collectionview cells
                    if let golfer = cell.golfer, let targetCell = playersVC.tableView.cellForRowAtIndexPath(cellIndexPath) {
                        //                  golfer.scores?.updateValue(Int(cell.scoreTextField.text!)!, forKey: tournee.day!)
                        
                        playersScores.updateValue(Int(cell.scoreTextField.text!)!, forKey: golfer.name!)
                        targetCell.detailTextLabel?.text = cell.scoreTextField.text
                        targetCell.setNeedsDisplay()
                    }
                    
                }
                
            }
            
            print("S C O R E S :-> \(playersScores)")
            
        }
        
    }
    
    
    
    
    
    // Called when navigation controller Back button pressed
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        
        if let controller = viewController as? PlayersTableViewController {
            print("Did we press the BACK buton?")
            
            let noOfGroups = controller.groups.count
            print("Number of groups is: \(noOfGroups)")
        }
    }
    
    
}
