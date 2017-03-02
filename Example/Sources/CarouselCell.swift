//
//  CarouselCell.swift
//  Example
//
//  Created by Bhargav Gurlanka on 4/25/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import UIKit
import Pickme

class CarouselCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        backgroundColor = .lightGray
        layer.contentsScale = UIScreen.main.scale
        layer.masksToBounds = false
        layer.shadowOpacity = 0.75;
        layer.shadowRadius = 5.0;
        layer.shadowOffset = .zero;
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        guard let attr = layoutAttributes as? LayoutAttributes else {
            return
        }
        
        label.alpha = 0.5 + (attr.scaleFactor - 1.0) / 2

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
}
