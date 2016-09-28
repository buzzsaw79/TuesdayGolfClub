//
//  EnterScoreViewController.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 19/09/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import UIKit
import CoreData

class EnterScoreViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var picker = UIPickerView()
    
    var scoreData = [Int]()
    
    var playerName: String?
    
    var players = [[Golfer]]()

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreTextField: UITextField!
    
    @IBAction func saveButton() {
        
//        self.navigationController?.popViewControllerAnimated(true)
        
        print("Save button pressed!")
        print("\(playerName!) -- score: \(playerScoreTextField.text!)")
        
        let aScore = playerScoreTextField.text!
        
        
        
    }
    
    
    
    
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
