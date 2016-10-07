//
//  EnterScoreCollectionViewCell.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 05/10/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import UIKit

class EnterScoreCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBOutlet weak var scoreTextField: UITextField!
    
    
    
    
}

class EnterScoreHeaderView: UICollectionReusableView {
    
    
    @IBOutlet weak var sectionHeaderTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.eggShell()
        
        sectionHeaderTitle.text = "Groupie"
    }
}