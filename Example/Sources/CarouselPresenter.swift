//
//  CarouselPresenter
//  Example
//
//  Created by Gurlanka, Bhargav (Agoda) on 02/03/17.
//  Copyright © 2017 Bhargav Gurlanka. All rights reserved.
//

import UIKit
import Pickme

struct CarouselPresenter: Presenter {
    func render(cell: CarouselCell, with image: UIImage, at: IndexPath) {
        cell.imageView.image = image
    }
}
