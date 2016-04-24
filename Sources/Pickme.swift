//
//  Pickme.swift
//  Pickme
//
//  Created by Bhargav Gurlanka on 4/23/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import UIKit


public class Pickme: NSObject {
    
    let config: Configuration
    weak var collectionView: UICollectionView?
    var items: [String]
    
    convenience public init(with view: UICollectionView, items: [String], @noescape configurator: (inout Configuration) -> ()) {
        var configuration = Configuration()
        configurator(&configuration)
        self.init(with: view, items: items, configuration: configuration)
    }
    
    public init(with view: UICollectionView, items models: [String], configuration: Configuration = Configuration()) {
        config = configuration
        collectionView = view
        items = models
        
        super.init()
        
        collectionView?.collectionViewLayout = Layout(with: config)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        if config.hideScrollbar {
            collectionView?.showsHorizontalScrollIndicator = false
        }
    }
    
    public func reload(withItems newItems: [String]) {
        items = newItems
        collectionView?.reloadData()
    }
    
    public func selectItem(atIndex index: Int) {
        guard let collectionView = collectionView,
            let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout else {
                return
        }
        
        let sectionInset = delegate.collectionView!(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAtIndex: 0)
        let itemSpacing = delegate.collectionView!(collectionView, layout: collectionView.collectionViewLayout, minimumInteritemSpacingForSectionAtIndex: 0)
        let itemSize = delegate.collectionView!(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAtIndexPath: NSIndexPath(forItem: index, inSection: 0))
        
        let row = CGFloat(index)
        collectionView.contentOffset = CGPoint(x: (row  * itemSize.width) + (row * itemSpacing), y: 0)
    }
}

extension Pickme: UICollectionViewDataSource {
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(config.cellIdentifier, forIndexPath: indexPath)
        
        if let pickerCell = cell as? PickmeCell {
            let model = items[indexPath.row]
            pickerCell.render(model, at: indexPath)
        }
        
        return cell
    }
}

extension Pickme: UICollectionViewDelegateFlowLayout {
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return config.itemSize
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let inset = (collectionView.frame.size.width - config.itemSize.width)/2
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return config.itemSpacing
    }
}