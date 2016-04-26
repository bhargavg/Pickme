//
//  MultiItemScaleViewController.swift
//  Example
//
//  Created by Bhargav Gurlanka on 4/23/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import UIKit
import Pickme

final class MultiItemScaleViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var picker: Pickme!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = (10...99).map(String.init)
        
        picker = Pickme(with: collectionView, items: items) { config in
            config.itemSpacing = 10.0
            config.itemSize = CGSize(width: 100.0, height: 100.0)
            config.flowDistance = 200.0
        }
        
        picker.selectItem(at: 29)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Received memory warning...!")
    }
}