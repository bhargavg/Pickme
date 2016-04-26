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
    public private(set) var selectedIndex: Int
    
    convenience public init(with view: UICollectionView, items: [String], @noescape configurator: (inout Configuration) -> ()) {
        var configuration = Configuration()
        configurator(&configuration)
        self.init(with: view, items: items, configuration: configuration)
    }
    
    public init(with view: UICollectionView, items models: [String], configuration: Configuration = Configuration()) {
        config = configuration
        collectionView = view
        items = models
        selectedIndex = 0
        
        super.init()
        
        let layout = Layout(configuration: config)
        layout.delegate = self;
        
        collectionView?.collectionViewLayout = layout
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
    
    public func selectItem(at index: Int, animation: Bool = true) {
        let indexPath = NSIndexPath(forItem: index, inSection: 0)
        collectionView?.layoutIfNeeded() // Trigger the layout
        collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: animation)
        selectedIndex = index
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
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectItem(at: indexPath.row)
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


extension Pickme: Delegate {
    func itemSelected(atIndex index: Int) {
        selectedIndex = index
    }
}