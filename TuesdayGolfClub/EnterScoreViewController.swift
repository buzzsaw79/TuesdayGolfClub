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
        print("🏁 playersScoreDictionary 🏁 -> \(playersScores)")
        let sortedByPlayersScoreArray = playersScores.sorted { $0.1 > $1.1 }
        
        
        if (todaysTournee?.addScores(dictionary: playersScores))!{
            print("Scores added to Today's Tournee")
        }
        
        // DEBUG
        print("Save button pressed!")
        print("🏁 sortedByPlayersScoreArray 🏁 -> \(sortedByPlayersScoreArray)")
        
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
        print("EnterScoreViewController viewDidLoad: \(String(describing: globalInt!+1))")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
                        let newIndexPath = IndexPath(item: cellIndex, section: globalInt!)
                        if let scoreInt = Int((cell?.scoreTextField.text!)!) {
                        //let day = Date.tomorrow
                        let day = Date.todayAsString()
                        _ = golfer.addScore(date: day, score: scoreInt)
                        } else {
                            print("No value input!")
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
                            print("\(golfer.name!)'s score of \(String(describing: cell?.scoreTextField.text)) saved!")
                        }
                    }
                    }
                }
                
            }
            
            //print("S C O R E S :-> \(playersScores)")
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
        
        // DEBUG
        print("all Cells count = \(allCells.count)")
        
        for scoreCell in allCells {
            let golfer = scoreCell.golfer!
            // NEED TO CHECK FOR EMPTY CELLS TO AVOID CRASH
            if let score = scoreCell.scoreTextField.text {
                if score.isEmpty {
                    print("You need to input a score for \(golfer.name!)")
                } else {
                    playersScores.updateValue(Int(score)!, forKey: golfer.name!)
                }
    
            } else {
                print("Insert value NOW!")
            }
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
