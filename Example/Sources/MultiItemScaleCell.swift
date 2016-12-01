//
//  MultiItemScaleCell.swift
//  Example
//
//  Created by Bhargav Gurlanka on 4/23/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import UIKit
import Pickme

class MultiItemScaleCell: UICollectionViewCell, PickmeCell {

    @IBOutlet weak var label: UILabel!
    
    func render(_ model: String, at: IndexPath) {
        label.text = model
        
         backgroundColor = .lightGray
         layer.contentsScale = UIScreen.main.scale
         layer.masksToBounds = false
         layer.shadowOpacity = 0.75;
         layer.shadowRadius = 5.0;
         layer.shadowOffset = .zero;
         layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        guard let attr = layoutAttributes as? LayoutAttributes else {
            return
        }
        
        label.alpha = 0.5 + (attr.scaleFactor - 1.0) / 2
    }
}
