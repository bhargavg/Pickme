//
//  SimplePickerPresenter.swift
//  Example
//
//  Created by Gurlanka, Bhargav (Agoda) on 02/03/17.
//  Copyright © 2017 Bhargav Gurlanka. All rights reserved.
//

import UIKit
import Pickme

struct SimplePickerPresenter: Presenter {
    func render(cell: SimplePickerCell, with model: String, at: IndexPath) {
        cell.label.text = model

        cell.backgroundColor = .lightGray
        cell.layer.contentsScale = UIScreen.main.scale
        cell.layer.masksToBounds = false
        cell.layer.shadowOpacity = 0.75;
        cell.layer.shadowRadius = 5.0;
        cell.layer.shadowOffset = .zero;
//        cell.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
}
