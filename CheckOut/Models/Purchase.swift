//
//  Purchase.swift
//  CheckOut
//
//  Created by SCIS on 5/26/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper


class Purchase: Mappable{
    
    var date: String?
    var purchaseLines: [PurchaseLine]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        date <- map["date"]
        purchaseLines <- map["products"]
    }
    
}
