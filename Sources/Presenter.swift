//
//  Presenter.swift
//  Pickme
//
//  Created by Bhargav Gurlanka on 02/03/17.
//  Copyright © 2017 Bhargav Gurlanka. All rights reserved.
//

import Foundation

public protocol Presenter {
    associatedtype CellType
    associatedtype ModelType

    func render(cell: CellType, with: ModelType, at: IndexPath)
}
