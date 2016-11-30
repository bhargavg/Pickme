//
//  Pickme.swift
//  Pickme
//
//  Created by Bhargav Gurlanka on 4/23/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import UIKit


open class Pickme: NSObject {
    
    let config: Configuration
    weak var collectionView: UICollectionView?
    var items: [String]
    open fileprivate(set) var selectedIndex: Int
    
    convenience public init(with view: UICollectionView, items: [String], configurator: (inout Configuration) -> ()) {
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
    
    open func reload(withItems newItems: [String]) {
        items = newItems
        collectionView?.reloadData()
    }
    
    open func selectItem(at index: Int, animation: Bool = true) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.layoutIfNeeded() // Trigger the layout
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animation)
        selectedIndex = index
    }
}

extension Pickme: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: config.cellIdentifier, for: indexPath)
        
        if let pickerCell = cell as? PickmeCell {
            let model = items[indexPath.row]
            pickerCell.render(model, at: indexPath)
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectItem(at: indexPath.row)
    }
}

extension Pickme: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return config.itemSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = (collectionView.frame.size.width - config.itemSize.width)/2
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return config.itemSpacing
    }
}


extension Pickme: Delegate {
    func itemSelected(atIndex index: Int) {
        selectedIndex = index
    }
}
