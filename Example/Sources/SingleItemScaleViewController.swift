//
//  SingleItemScaleViewController.swift
//  Example
//
//  Created by Bhargav Gurlanka on 4/25/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import UIKit
import Pickme

final class SingleItemScaleViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var picker: Pickme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = (10...99).map(String.init)
        
        picker = Pickme(with: collectionView, items: items) { config in
            config.itemSpacing = 10.0
            config.itemSize = CGSize(width: 50.0, height: 50.0)
            config.flowDistance = 90.0
        }
        
        picker.selectItem(at: 9, animation: false)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Received memory warning...!")
    }
}
