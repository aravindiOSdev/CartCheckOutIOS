//
//  Cart.swift
//  CheckOut
//
//  Created by SCIS on 5/26/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper


class Cart: Mappable{
    
    var item: Item?
    var qty: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        item <- map["product"]
        qty <- map["quantity"]
    }
    
}
