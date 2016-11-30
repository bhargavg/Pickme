//
//  SimplePickerCell.swift
//  Example
//
//  Created by Bhargav Gurlanka on 4/25/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import UIKit
import Pickme

class SimplePickerCell: UICollectionViewCell, PickmeCell {
    
    @IBOutlet weak var label: UILabel!
    
    func render(_ model: String, at: IndexPath) {
        label.text = model
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        guard let attr = layoutAttributes as? LayoutAttributes else {
            return
        }
        
        label.alpha = 0.5 + (attr.scaleFactor - 1.0) / 2
        
    }
}
