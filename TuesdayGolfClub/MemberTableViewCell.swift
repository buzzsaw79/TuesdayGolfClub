//
//  MemberTableViewCell.swift
//  TuesdayClub
//
//  Created by Keith Bamford on 07/08/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberHandicapLabel: UILabel!
    @IBOutlet weak var memberNamelabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("MTVCell called awakefromNib")
        
//        self.backgroundColor = UIColor.evenCellColour()
        memberNamelabel.textColor = UIColor.evenCellTextColour()
        memberHandicapLabel.textColor = UIColor.richRed()
        
        // Make a circular image
        memberImage.layer.cornerRadius = memberImage.frame.size.width / 2
        memberImage.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
//        print("--- MemberTableViewCell.setSelected called ---")

        // Configure the view for the selected state
        if(!selected) {
            self.contentView.backgroundColor = UIColor.evenCellColour()
            memberNamelabel.textColor = UIColor.evenCellTextColour()
            self.memberHandicapLabel.textColor = UIColor.richRed()
        } else {
            self.contentView.backgroundColor = UIColor.redColor()
            self.memberNamelabel.textColor = UIColor.whiteColor()
            self.memberHandicapLabel.textColor = UIColor.whiteColor()
        }
    }
    
}
