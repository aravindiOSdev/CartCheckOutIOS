//
//  Banner.swift
//  CheckOut
//
//  Created by SCIS on 4/24/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import Foundation
import UIKit

class Banner {
    var itemName: String
    var title: String
    var image: UIImage
    
    init(itemName: String, title: String, image: UIImage) {
        self.title = title
        self.itemName = itemName
        self.image = image

    }
}
