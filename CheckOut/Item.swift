//
//  Item.swift
//  CheckOut
//
//  Created by SCIS on 4/20/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import Foundation
import UIKit

class Item {
    var id: Int
    var name: String
    var type: String
    var image: UIImage
    var image2: UIImage
    var price: Int
    init(id: Int, name: String, type: String, image: UIImage, image2: UIImage, price: Int) {
        self.id = id
        self.name = name
        self.type = type
        self.image = image
        self.image2 = image2
        self.price = price
    }
}
