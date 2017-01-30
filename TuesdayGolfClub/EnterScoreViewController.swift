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
    
    var todaysTournee: Tournee? {
        didSet {
            if let moc = todaysTournee?.managedObjectContext {
                manObjCon = moc
            }
        }
    }
    
    
    var manObjCon: NSManagedObjectContext?
    
    // Temp score holder
    var playersScores = [String:Int]()
    
    weak var cvDelegate: UICollectionViewDelegate?
    weak var cvDataSource: UICollectionViewDataSource?
    
    
    @IBOutlet weak var enterScoreCollectionView: UICollectionView!
    
    @IBAction func saveButton() {
        playersScores = getDataOutOfEntireCollectionView()
        
        let sortedByPlayersScoreArray = playersScores.sorted { $0.1 > $1.1 }
        
        // DEBUG
        print("Save button pressed!")
        print("🏁 sortedByPlayersScoreArray 🏁 -> \(sortedByPlayersScoreArray)")
        
//        playersScores = sortedByPlayersScoreArray
    }
    
    
    
    //MARK: -
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VIEWDIDLOAD")
        enterScoreCollectionView.delegate = self.cvDelegate!
        enterScoreCollectionView.dataSource = self.cvDataSource!
        
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
        
        cell.playerNameLabel.text = cell.golfer!.name
        if cell.isScoreUpdated {
            
            cell.scoreTextField.text = "Updated"
        }
        
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

    
    //MARK: -
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            
        let headerSizeWidth = self.view.bounds.width
        let headerSizeHeight = CGFloat(48)
        return CGSize(width: headerSizeWidth, height: headerSizeHeight)
  
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let aSize = (self.view.bounds.width - 32.0)/3
        let cellSize = CGSize(width: aSize, height: aSize)
            return cellSize
        
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
            
            print("PREPARE = back2")
            
            // Triggered by Unwind segue when "Save" button clicked
            let playersVC = segue.destination as! PlayersTableViewController
            
            let numberOfSections = enterScoreCollectionView.numberOfSections
            for section in 0..<numberOfSections {
                let sectionIndex = section
                
                for item in 0..<enterScoreCollectionView.numberOfItems(inSection: sectionIndex) {
                    let cellIndex = item
                    let cellIndexPath = IndexPath(item: cellIndex, section: sectionIndex)
                    // !!! CRASH - cellForItem only returns visible cells !!!
                    let cell = enterScoreCollectionView.cellForItem(at: cellIndexPath) as? EnterScoreCollectionViewCell
                    
                    
                    
                    // Get score data from collectionview cells
                    if let golfer = cell?.golfer {
                        
                        let scoreInt = Int((cell?.scoreTextField.text)!)!
                        let day = self.todaysTournee?.todayAsString() ?? "today"
                        
                        golfer.scores.updateValue(scoreInt, forKey: day)
                        // Causes crash when enterScoreVC cell are empty
                        playersScores.updateValue(Int((cell?.scoreTextField.text!)!) ?? 0, forKey: golfer.name!)
                        let targetCell = playersVC.tableView.cellForRow(at: cellIndexPath) as! PlayersTableViewCell
                        
                        targetCell.textLabel?.text = golfer.name!
                        targetCell.detailTextLabel?.text = cell?.scoreTextField.text
                        targetCell.detailTextLabel?.textColor = UIColor.richRed()
                        targetCell.detailTextLabel?.attributedText?.size()
                        targetCell.isSelected = true
                        targetCell.isScoreUpdated = true
                        targetCell.setNeedsDisplay()
                    }
                    
                }
                
            }
            
            print("S C O R E S :-> \(playersScores)")
            print("G O L F E R S:-> \(players)")
            
        }
        
    }
    
    
    func getDataOutOfEntireCollectionView() -> [String:Int] {
        print("GETDATAOUTOFENTIRECOLLECTIONVIEW")
        var playersScores = [String:Int]()
        
        // Store original CV frame and get content size
        let refCVOrigin = self.enterScoreCollectionView.frame.origin
        let refCVSize = self.enterScoreCollectionView.frame.size
        let contentSize = self.enterScoreCollectionView.collectionViewLayout.collectionViewContentSize
        
        // expand CV size to match content size and redraw it
        self.enterScoreCollectionView.frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
        self.enterScoreCollectionView.collectionViewLayout.invalidateLayout()
//        self.enterScoreCollectionView.reloadData()
        
        // Attempt to Get data from EnterScoreCollectionViewCell
        let allCells = self.enterScoreCollectionView.visibleCells as! [EnterScoreCollectionViewCell]
        
        print("all Cells count = \(allCells.count)")
        
        for scoreCell in allCells {
            let golfer = scoreCell.golfer!
//            playersScores.updateValue(Int(scoreString)!, forKey: golfer.name!)
            playersScores.updateValue(Int((scoreCell.scoreTextField.text!)) ?? 0, forKey: golfer.name!)
        }
        
        
        // restore original CV frame
        self.enterScoreCollectionView.frame = CGRect(x: refCVOrigin.x, y: refCVOrigin.y, width: refCVSize.width, height: refCVSize.height)
        
        
        return playersScores
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
