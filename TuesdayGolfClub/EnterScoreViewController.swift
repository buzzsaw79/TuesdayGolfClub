//
//  EnterScoreViewController.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 19/09/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import UIKit
import CoreData

class EnterScoreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
    
    //MARK: -
    //MARK: Properties
    
    var playerName: String?
    
    var players = [[Golfer]]()
    
    @IBOutlet weak var enterScoreCollectionView: UICollectionView!
    
    @IBAction func saveButton() {
        // DEBUG
        print("Save button pressed!")
        
       let indexPaths = enterScoreCollectionView.indexPathsForVisibleItems()
   
    }
    
    // Called when navigation controller Back button pressed
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        
        if let controller = viewController as? PlayersTableViewController {
        print("Did we press the BACK buton?")
            
            let noOfGroups = controller.groups.count
            print("Number of groups is: \(noOfGroups)")
        }
    }
    
    //MARK: -
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterScoreCollectionView.delegate = self
        enterScoreCollectionView.dataSource = self
        
        navigationController?.delegate = self
        // DEBUG
        
        print("#### enterScoreVC Players array:\(players)")
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
        
        cell.playerNameLabel.text = cell.golfer!.name
        
        
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
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let aSize = (self.view.bounds.width - 24.0)/4
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
            
            // DEBUG
            print("BACK BACK")
            
            // Get score data from collectionview cells
            let playersVC = segue.destinationViewController as! PlayersTableViewController
            let indexPaths = enterScoreCollectionView.indexPathsForVisibleItems()
            
            for aPath in indexPaths {
                let cell = enterScoreCollectionView.cellForItemAtIndexPath(aPath) as! EnterScoreCollectionViewCell
                let score = cell.scoreTextField.text
                
                if let targetCell = playersVC.tableView.cellForRowAtIndexPath(aPath) {
                    targetCell.detailTextLabel?.text = score
                    // DEBUG
                    print("SCORE: \(targetCell.detailTextLabel?.text)")
                    playersVC.tableView.reloadData()
                }
            }
            
            
        }
        // DEBUG
        //print("%%%%%% EnterScoreViewController prepareForSegue Sender: \(sender!) %%%%%%")
        
    }
    
    
}
