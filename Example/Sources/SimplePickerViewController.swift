//
//  SimplePickerViewController.swift
//  Example
//
//  Created by Bhargav Gurlanka on 4/25/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import UIKit
import Pickme

class SimplePickerViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var picker: Pickme<SimplePickerCell, String, SimplePickerPresenter>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = (10...99).map(String.init)
        
        picker = Pickme(with: collectionView, items: items, presenter: SimplePickerPresenter())
        
        picker.selectItem(at: 5)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Received memory warning...!")
    }
}
