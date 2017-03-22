//
//  Delegate.swift
//  Pickme
//
//  Created by Bhargav Gurlanka on 4/25/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import Foundation

public protocol Delegate: class {
    func itemSelected(atIndex index: Int)
}
