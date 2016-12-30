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
        let sortedByPlayersScoreArray = playersScores.sorted { $0.1 > $1.1 }
        
        
        
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return players.count
//        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = enterScoreCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.Storyboard.EnterScoreCellIdentifier, for: indexPath) as! EnterScoreCollectionViewCell
        
        
        cell.golfer = self.players[indexPath.section][indexPath.row]
        
        cell.playerNameLabel.text = cell.golfer!.firstName
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "EnterScoreHeaderView", for: indexPath) as! EnterScoreHeaderView
        
        
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
    /*
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        // if indexPath contains the specified section AND
        //    the condition for hiding this section is `true`
        //       return CGFloat(0)
        // else
        //    return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        // similar logic to set header height
    }
    */
    
    
    
    
    
    
    
    
    
    
    
    //MARK: -
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 1 {
            
        let headerSizeWidth = self.view.bounds.width
        let headerSizeHeight = CGFloat(48)
        return CGSize(width: headerSizeWidth, height: headerSizeHeight)
        
        
            
        } else {
            return CGSize(width: 0, height: 0)
        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
        let aSize = (self.view.bounds.width - 32.0)/3
        let cellSize = CGSize(width: aSize, height: aSize)
            return cellSize
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        
//        return UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0)
//        
////        if section == 1 {
////            return UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0)
////        } else {
////            return UIEdgeInsetsMake(0, 0, 0, 0)
////        }
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
////        if section == 1 {
////            return CGFloat(0)
////        } else {
////            return CGFloat(8.0)
////        }
//        
//        return CGFloat(8.0)
//    }
    
    var CVCCount = 0
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        CVCCount = CVCCount + 1
        
        // DEBUG
        //print("\(CVCCount)About to display EnterScoreCollectionViewCell: \(cell)")
    }
    
    // MARK:
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "back2" {
            // Triggered by Unwind segue when "Save" button clicked
            let playersVC = segue.destination as! PlayersTableViewController
            
            let numberOfSections = enterScoreCollectionView.numberOfSections
            for section in 0..<numberOfSections {
                let sectionIndex = section
                
                for item in 0..<enterScoreCollectionView.numberOfItems(inSection: sectionIndex) {
                    let cellIndex = item
                    let cellIndexPath = IndexPath(item: cellIndex, section: sectionIndex)
                    let cell = enterScoreCollectionView.cellForItem(at: cellIndexPath) as! EnterScoreCollectionViewCell
                    
                    // Get score data from collectionview cells
                    if let golfer = cell.golfer, let targetCell = playersVC.tableView.cellForRow(at: cellIndexPath) {
                        //                  golfer.scores?.updateValue(Int(cell.scoreTextField.text!)!, forKey: tournee.day!)
                        // Causes crash when enterScoreVC cell are empty
                        playersScores.updateValue(Int(cell.scoreTextField.text!) ?? 0, forKey: golfer.name!)
                        targetCell.detailTextLabel?.text = cell.scoreTextField.text
                        targetCell.detailTextLabel?.textColor = UIColor.richRed()
                        targetCell.detailTextLabel?.attributedText?.size()
                        targetCell.setNeedsDisplay()
                    }
                    
                }
                
            }
            
            print("S C O R E S :-> \(playersScores)")
            
        }
        
    }
    
    
    
    
    
    // Called when navigation controller Back button pressed
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        if let controller = viewController as? PlayersTableViewController {
            print("Did we press the BACK buton?")
            
            let noOfGroups = controller.groups.count
            print("Number of groups is: \(noOfGroups)")
        }
    }
    
    
}
