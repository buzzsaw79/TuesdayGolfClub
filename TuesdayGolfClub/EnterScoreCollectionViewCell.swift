//
//  EnterScoreCollectionViewCell.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 05/10/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import UIKit

class EnterScoreCollectionViewCell: UICollectionViewCell, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    //MARK: -
    //MARK: Properties
    
    private var picker = UIPickerView()
    
    var pickerViewScoreData = [Int]()
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBOutlet weak var scoreTextField: UITextField!
    
    var golfer:Golfer?
    
    
    var unselected: Bool? {
        didSet {
            if let trueOrFalse = unselected {
                switch trueOrFalse {
                case true:
                    print("Its true, I tell you!")
                case false:
                    print("Its false")
                }
            }
        }
    }
    
    func tagScoreTextField(textField: UITextField) -> UITextField {
        return UITextField()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
    let reducedTextRect = CGRectMake(scoreTextField.frame.minX, scoreTextField.frame.minY, scoreTextField.frame.width/2, scoreTextField.frame.height/4)
    
    scoreTextField.delegate = self
    scoreTextField.adjustsFontSizeToFitWidth = true
    scoreTextField.placeholder = "Score"
    scoreTextField.drawPlaceholderInRect(reducedTextRect)
    
    playerNameLabel.adjustsFontSizeToFitWidth = true
    
    picker.dataSource = self
    picker.delegate = self
    
    for index in 13...48 {
    pickerViewScoreData.append(index)
    }
    
    picker.selectRow(pickerViewScoreData.count/2, inComponent: 0, animated: true)
    scoreTextField.inputView = picker
        if scoreTextField.hasText() {
            let tempScoreHolder = scoreTextField.text
        }
    }
    
    
    //MARK: -
    //MARK: PickerView Delegate
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerViewScoreData.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        scoreTextField.text = String(pickerViewScoreData[row])
        scoreTextField.resignFirstResponder()
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerViewScoreData[row])
    }
    
    
    
}



// MARK: -
// MARK: -

class EnterScoreHeaderView: UICollectionReusableView {
    
    
    @IBOutlet weak var sectionHeaderTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.whiteColor()
    }
}