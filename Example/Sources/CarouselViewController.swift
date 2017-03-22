//
//  CarouselViewController.swift
//  Example
//
//  Created by Bhargav Gurlanka on 4/25/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import UIKit
import Pickme

final class CarouselViewController: UIViewController, Delegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var picker: Pickme<CarouselCell, UIImage, CarouselPresenter>!
    let items = [
        #imageLiteral(resourceName: "bingsu"),
        #imageLiteral(resourceName: "candle"),
        #imageLiteral(resourceName: "duck"),
        #imageLiteral(resourceName: "heart"),
        #imageLiteral(resourceName: "rooftop")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker = Pickme(with: collectionView, items: items, presenter: CarouselPresenter()) { config in
            config.itemSpacing = 10.0
            config.itemSize = CGSize(width: 100.0, height: 100.0)
            config.flowDistance = 200.0
        }
        
        picker.selectItem(at: 3, animation: false)

        picker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Received memory warning...!")
    }

    func itemSelected(atIndex index: Int) {
        print(items[index]);
    }
}
