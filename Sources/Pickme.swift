//
//  Pickme.swift
//  Pickme
//
//  Created by Bhargav Gurlanka on 4/23/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import UIKit


open class Pickme<CellType, ModelType, PresenterType: Presenter>: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout where PresenterType.CellType == CellType, PresenterType.ModelType == ModelType{
    
    let config: Configuration
    weak var collectionView: UICollectionView?
    var items: [ModelType]
    public weak var delegate: Delegate?
    let presenter: PresenterType
    open fileprivate(set) var selectedIndex: Int
    
    convenience public init(with view: UICollectionView, items: [ModelType], presenter: PresenterType, configurator: (inout Configuration) -> ()) {
        var configuration = Configuration()
        configurator(&configuration)
        self.init(with: view, items: items, presenter: presenter, configuration: configuration)
    }
    
    public init(with view: UICollectionView, items models: [ModelType], presenter: PresenterType, configuration: Configuration = Configuration()) {
        self.config = configuration
        self.collectionView = view
        self.items = models
        self.selectedIndex = 0
        self.presenter = presenter
        
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
    
    open func reload(withItems newItems: [ModelType]) {
        items = newItems
        collectionView?.reloadData()
    }
    
    open func selectItem(at index: Int, animation: Bool = true) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.layoutIfNeeded() // Trigger the layout
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animation)
        selectedIndex = index
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: config.cellIdentifier, for: indexPath)
        let model = items[indexPath.row]

        if let cell = cell as? CellType {
            presenter.render(cell: cell, with: model, at: indexPath)
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectItem(at: indexPath.row)
    }

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
    public func itemSelected(atIndex index: Int) {
        selectedIndex = index
        delegate?.itemSelected(atIndex: index)
    }
}
