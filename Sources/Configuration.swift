//
//  Configuration.swift
//  Pickme
//
//  Created by Bhargav Gurlanka on 4/24/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import UIKit

public struct Configuration {
    public var minScale: CGFloat
    public var maxScale: CGFloat
    public var itemSpacing: CGFloat
    public var itemSize: CGSize
    public var cellIdentifier: String
    public var hideScrollbar: Bool
    public var flowDistance: CGFloat

    public init() {
        minScale = 1.0
        maxScale = 2.0
        itemSpacing = 10.0
        itemSize = CGSize(width: 50, height: 50)
        cellIdentifier = "Cell"
        hideScrollbar = true
        flowDistance = 50.0
    }
}
