//
//  EnterScoreViewController.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 19/09/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import UIKit
import CoreData

class EnterScoreViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: -
    //MARK: Properties
    
    private let grid = 2
    
    private var picker = UIPickerView()
    
    var scoreData = [Int]()
    
    var playerName: String?
    
    var players = [[Golfer]]()

    @IBOutlet weak var enterScoreCollectionView: UICollectionView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreTextField: UITextField!
    
    @IBAction func saveButton() {
        
//        self.navigationController?.popViewControllerAnimated(true)
        
        print("Save button pressed!")
        print("\(playerName!) -- score: \(playerScoreTextField.text!)")
        
        let aScore = playerScoreTextField.text!
        
        
        
    }

    //MARK: -
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reducedTextRect = CGRectMake(playerScoreTextField.frame.minX, playerScoreTextField.frame.minY, playerScoreTextField.frame.width, playerScoreTextField.frame.height/4)

        // Do any additional setup after loading the view.
        playerNameLabel.text = playerName
        
        playerScoreTextField.delegate = self
        playerScoreTextField.adjustsFontSizeToFitWidth = true
        playerScoreTextField.placeholder = "Enter Score Here"
        playerScoreTextField.drawPlaceholderInRect(reducedTextRect)
        
        
        
        picker.dataSource = self
        picker.delegate = self
        
        for index in 13...48 {
            scoreData.append(index)
        }
        
        picker.selectRow(scoreData.count/2, inComponent: 0, animated: true)
        playerScoreTextField.inputView = picker
        
        
        
        enterScoreCollectionView.delegate = self
        enterScoreCollectionView.dataSource = self
        
        
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
        
        
        let golfer = self.players[indexPath.section][indexPath.row]
        
        cell.playerNameLabel.text = golfer.name
        
        
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
            headerTitleString = "Another Group"
        }
        
        
        headerView.sectionHeaderTitle.text = headerTitleString
 
        return headerView
    }
    
    //MARK: -
    //MARK: UICollectionViewDelegateFlowLayout
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let aSize = (self.view.bounds.width - 24.0)/2
        let cellSize = CGSizeMake(aSize, aSize)
        return cellSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 8.0
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
//        return 8.0
//    }
    
    
    //MARK: -
    //MARK: PickerView Delegate
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return scoreData.count
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        playerScoreTextField.text = String(scoreData[row])
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(scoreData[row])
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let playersVC = segue.destinationViewController as! PlayersTableViewController
        print("\(playersVC.groups.debugDescription)")
        
        
        if segue.identifier == "back2" {
            
        
        
//        playersVC.tableView.
        print("EnterScoreView prepareForSegue Sender: \(sender)")
            
            
            playersVC.playersArray.count
        
        }
        
    }
   

}
