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

var globalInt: Int?


class EnterScoreViewController: UIViewController, UINavigationControllerDelegate {
    
    //MARK: -
    //MARK: Properties
    
    var playerName: String?
    var players = [[Golfer]]()
    var headerText: String = " "
    
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
    
    //MARK: -
    //MARK: Actions
    
    @IBAction func saveButton() {
        playersScores = getDataOutOfEntireCollectionView()
        //DEBUG
        //        print("ESVC playersScoreDictionary: \(playersScores)\n")
        let sortedByPlayersScoreArray = playersScores.sorted { $0.1 > $1.1 }
        
        
        if (todaysTournee?.addScores(dictionary: playersScores))!{
            //DEBUG
            print("ESVC Scores added to Today's Tournee\n")
        }
        
        // DEBUG
        print("ESVC Save button pressed!\n")
        print("ESVC sortedByPlayersScoreArray: \(sortedByPlayersScoreArray)\n")
        
        todaysTournee?.completed = true
        Tournee.saveTournee(tournee: todaysTournee!)
        
        
        }
    
    
    
    //MARK: -
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        enterScoreCollectionView.delegate = self.cvDelegate!
        enterScoreCollectionView.dataSource = self.cvDataSource!
        
        navigationController?.delegate = self
        
        //enterScoreHeaderView.sectionHeaderTitle
        
        // DEBUG
//        print("ESVC viewDidLoad: \(String(describing: globalInt!+1))")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "back2" {
            //DEBUG
            print("ESVC PREPARE = back2")
            
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
                        let newIndexPath = IndexPath(item: cellIndex, section: globalInt!)
                        if let scoreInt = Int((cell?.scoreTextField.text!)!) {
                        //let day = Date.tomorrow
                        let day = Date.todayAsString()
                        _ = golfer.addScore(date: day, score: scoreInt)
                        } else {
                            print("ESVC No value input!")
                        }
                        
                        if let targetCell = playersVC.tableView.cellForRow(at: newIndexPath) as! PlayersTableViewCell? {
                        
                        targetCell.textLabel?.text = golfer.name!
                        targetCell.detailTextLabel?.text = cell?.scoreTextField.text
                        targetCell.detailTextLabel?.textColor = UIColor.richRed()
                        targetCell.detailTextLabel?.attributedText?.size()
                        targetCell.isSelected = true
                        targetCell.isScoreUpdated = true
                        targetCell.setNeedsDisplay()
                        
                        // Save golfer back to CoreData
                        if Golfer.saveGolfer(golfer: golfer) {
                            //DEBUG
                            print("ESVC \(golfer.name!)'s score of \(String(describing: cell?.scoreTextField.text)) saved!\n")
                        }
                    }
                    }
                }
                
            }
            
            //print("ESVC S C O R E S :-> \(playersScores)\n")
//            print("ESVC G O L F E R S:-> \(players)\n")
            
        }
        
    }
    
    
    func getDataOutOfEntireCollectionView() -> [String:Int] {
        //DEBUG
        print("ESVC GETDATAOUTOFENTIRECOLLECTIONVIEW")
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
        
        // DEBUG
//        print("ESVC all Cells count = \(allCells.count)\n")
        
        for scoreCell in allCells {
            let golfer = scoreCell.golfer!
            // NEED TO CHECK FOR EMPTY CELLS TO AVOID CRASH
            if let score = scoreCell.scoreTextField.text {
                if score.isEmpty {
                    print("ESVC You need to input a score for \(golfer.name!)\n")
                } else {
                    playersScores.updateValue(Int(score)!, forKey: golfer.name!)
                }
    
            } else {
                //DEBUG
                print("ESVC Insert value NOW!\n")
            }
        }
 
        // restore original CV frame
        self.enterScoreCollectionView.frame = CGRect(x: refCVOrigin.x, y: refCVOrigin.y, width: refCVSize.width, height: refCVSize.height)
        
        
        return playersScores
    }
    
    
    
    
    
    
    // Called when navigation controller Back button pressed
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        if let controller = viewController as? PlayersTableViewController {
            //DEBUG
            print("ESVC NavigationController - Did we press the BACK buton?\n")
            
            let noOfGroups = controller.groups.count
            //DEBUG
            print("ESVC NavigationController - Number of groups is: \(noOfGroups)\n")
        }
    }
    
}
