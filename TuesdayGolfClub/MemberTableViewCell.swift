//
//  MemberTableViewCell.swift
//  TuesdayClub
//
//  Created by Keith Bamford on 07/08/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
    
    //MARK: -
    //MARK: Outlets
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberHandicapLabel: UILabel!
    @IBOutlet weak var memberNamelabel: UILabel!
    
    
    //MARK: -
    //MARK: View Controller Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //DEBUG
//        print("MTVCell called awakefromNib")
        
//        self.backgroundColor = UIColor.evenCellColour()
        memberNamelabel.textColor = UIColor.evenCellTextColour()
        memberHandicapLabel.textColor = UIColor.richRed()
        
        // Make a circular image
        memberImage.layer.cornerRadius = memberImage.frame.size.width / 2
        memberImage.clipsToBounds = true
        
        
        
    }
    
    //MARK: -
    //MARK: UITableViewCell Methods - Overridden!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //DEBUG
//        print("--- MemberTableViewCell.setSelected called ---")

        // Configure the view for the selected state
        if(!selected) {
            self.contentView.backgroundColor = UIColor.evenCellColour()
            memberNamelabel.textColor = UIColor.evenCellTextColour()
            self.memberHandicapLabel.textColor = UIColor.richRed()
        } else {
            self.contentView.backgroundColor = UIColor.red
            self.memberNamelabel.textColor = UIColor.white
            self.memberHandicapLabel.textColor = UIColor.white
        }
    }
    
}
