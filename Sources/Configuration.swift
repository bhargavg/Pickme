//
//  Configuration.swift
//  Pickme
//
//  Created by Bhargav Gurlanka on 4/24/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import UIKit

public struct Configuration {
    public var minScale: CGFloat = 1.0
    public var maxScale: CGFloat = 2.0
    public var itemSpacing: CGFloat = 10.0
    public var itemSize: CGSize = CGSize(width: 50, height: 50)
    public var cellIdentifier: String = "Cell"
    public var hideScrollbar: Bool = true
    public var flowDistance: CGFloat = 50.0
}
