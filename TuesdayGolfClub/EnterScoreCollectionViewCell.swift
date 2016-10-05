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
    
    override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attribs = super.preferredLayoutAttributesFittingAttributes(layoutAttributes)
        return attribs
    }
    
    
}
