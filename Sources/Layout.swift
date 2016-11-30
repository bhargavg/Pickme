//
//  Layout.swift
//  Pickme
//
//  Created by Bhargav Gurlanka on 4/24/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import UIKit


final class Layout: UICollectionViewFlowLayout {
    
    var selectedIndexPath: IndexPath?
    var cachedAttributes = [LayoutAttributes]()
    var contentSize = CGSize()
    let config: Configuration
    weak var delegate: Delegate?
    
    init(configuration: Configuration) {
        config = configuration
        super.init()
        scrollDirection = .horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layoutAttributesClass : AnyClass {
        return LayoutAttributes.self
    }
    
    override func prepare() {
        guard let collectionView = collectionView,
            let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
            let dataSource = collectionView.dataSource else {
                return
        }
        
        let itemsCount = dataSource.collectionView(collectionView, numberOfItemsInSection: 0)
        let sectionInset = delegate.collectionView!(collectionView, layout: self, insetForSectionAt: 0)
        let itemSpacing = config.itemSpacing
        var itemsWidth = CGFloat()
        
        let attributes: [LayoutAttributes] = (0..<itemsCount).map { row in
            let indexPath = IndexPath(item: row, section: 0)
            let attribute = LayoutAttributes(forCellWith: indexPath)
            let itemSize = delegate.collectionView!(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: attribute.indexPath)
            
            let itemOriginX = sectionInset.left + (CGFloat(row) * itemSize.width) + (CGFloat(row) * itemSpacing)
            let itemOriginY = (collectionView.frame.size.height / 2) - (itemSize.height / 2)
            attribute.frame = CGRect(origin: CGPoint(x: itemOriginX, y: itemOriginY), size: itemSize)
            
            itemsWidth += itemSize.width
            
            return attribute
        }
        
        cachedAttributes = attributes
        
        let width  = sectionInset.left + itemsWidth + (CGFloat(itemsCount - 1) * itemSpacing) + sectionInset.right
        
        let height = collectionView.frame.size.height
        contentSize = CGSize(width: width, height: height)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let row = indexPath.row
        return row < cachedAttributes.count ? cachedAttributes[row] : nil
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else {
            return nil
        }
        
        let attributes = cachedAttributes.filter{ $0.frame.intersects(rect) }
        
        let modifiedAttributes: [UICollectionViewLayoutAttributes] = attributes.map { attr in
            let attribute = attr.copy() as! LayoutAttributes
            
            let distance = (collectionView.center.x + collectionView.contentOffset.x) - attribute.center.x
            let absDistance = abs(distance)
            
            let factor = 1.0 - min(absDistance / config.flowDistance, 1.0)
            let normalizedScale = config.minScale + ((config.maxScale - config.minScale) * factor)
            
            attribute.transform = CGAffineTransform(scaleX: normalizedScale, y: normalizedScale)
            attribute.zIndex = Int(20 * normalizedScale)
            attribute.scaleFactor = normalizedScale
            
            return attribute
        }
        
        return modifiedAttributes
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let collectionViewSize = self.collectionView!.bounds.size
        let proposedContentOffsetCenterX = proposedContentOffset.x + collectionViewSize.width * 0.5
        
        let proposedRect = self.collectionView!.bounds
        
        // Comment out if you want the collectionview simply stop at the center of an item while scrolling freely
        // let proposedRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionViewSize.width, height: collectionViewSize.height)
        
        var candidateAttributes: UICollectionViewLayoutAttributes?
        for attributes in self.layoutAttributesForElements(in: proposedRect)! {
            // == Skip comparison with non-cell items (headers and footers) == //
            if attributes.representedElementCategory != .cell {
                continue
            }
            
            
            // Get collectionView current scroll position
            let currentOffset = self.collectionView!.contentOffset
            
            // Don't even bother with items on opposite direction
            // You'll get at least one, or else the fallback got your back
            if (attributes.center.x < (currentOffset.x + collectionViewSize.width * 0.5) && velocity.x > 0) || (attributes.center.x > (currentOffset.x + collectionViewSize.width * 0.5) && velocity.x < 0) {
                continue
            }
            
            
            // First good item in the loop
            if candidateAttributes == nil {
                candidateAttributes = attributes
                continue
            }
            
            
            // Save constants to improve readability
            let lastCenterOffset = candidateAttributes!.center.x - proposedContentOffsetCenterX
            let centerOffset = attributes.center.x - proposedContentOffsetCenterX
            
            if fabsf( Float(centerOffset) ) < fabsf( Float(lastCenterOffset) ) {
                candidateAttributes = attributes
            }
        }
        
        if let attributes = candidateAttributes {
            selectedIndexPath = attributes.indexPath
            // Great, we have a candidate
            
            if let delegate = delegate,
               let row = selectedIndexPath?.row {
                delegate.itemSelected(atIndex: row)
            }
            
            return CGPoint(x: attributes.center.x - collectionViewSize.width * 0.5, y: proposedContentOffset.y)
        } else {
            // Fallback
            selectedIndexPath = nil
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }
    }
    
    override var collectionViewContentSize : CGSize {
        return contentSize
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
