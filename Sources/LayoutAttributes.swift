//
//  LayoutAttributes.swift
//  Pickme
//
//  Created by Bhargav Gurlanka on 4/24/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import UIKit

public final class LayoutAttributes: UICollectionViewLayoutAttributes {
    
    public var scaleFactor: CGFloat = 0
    
    override public func copy(with zone: NSZone?) -> Any {
        let copy = super.copy(with: zone) as! LayoutAttributes
        copy.scaleFactor = scaleFactor
        return copy
    }
    
    override public func isEqual(_ object: Any?) -> Bool {
        guard let attribute = object as? LayoutAttributes, super.isEqual(object) else {
            return false
        }
        
        return attribute.scaleFactor == scaleFactor
    }
}
