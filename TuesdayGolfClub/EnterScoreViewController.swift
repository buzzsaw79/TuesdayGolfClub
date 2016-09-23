//
//  EnterScoreViewController.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 19/09/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import UIKit

class EnterScoreViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var picker = UIPickerView()
    
    var scoreData = [Int]()
    

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreTextField: UITextField!
    
    @IBAction func saveButton() {
        
        self.navigationController?.popViewControllerAnimated(true)
        
        print("Save button pressed!")
        print("\(playerName!) -- score: \(playerScoreTextField.text!)")
        
    }
    
    
    
    var playerName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playerNameLabel.text = playerName
        
        playerScoreTextField.delegate = self
        picker.dataSource = self
        picker.delegate = self
        picker.showsSelectionIndicator = true
        
        for index in 13...48 {
            scoreData.append(index)
        }
        
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
        
//        playersVC.tableView.
        print("EnterScoreView prepareForSegue Sender: \(sender)")
        
        
        
    }
   

}
