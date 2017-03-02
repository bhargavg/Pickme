//
//  CarouselViewController.swift
//  Example
//
//  Created by Bhargav Gurlanka on 4/25/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import UIKit
import Pickme

final class CarouselViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var picker: Pickme<CarouselCell, String, CarouselPresenter>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = (10...99).map(String.init)
        
        picker = Pickme(with: collectionView, items: items, presenter: CarouselPresenter()) { config in
            config.itemSpacing = 10.0
            config.itemSize = CGSize(width: 100.0, height: 100.0)
            config.flowDistance = 200.0
        }
        
        picker.selectItem(at: 9, animation: false)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Received memory warning...!")
    }
}
