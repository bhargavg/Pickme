//
//  PickmeCell.swift
//  Pickme
//
//  Created by Bhargav Gurlanka on 4/24/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

public protocol PickmeCell {
    func render(_ model: String, at: IndexPath)
}
