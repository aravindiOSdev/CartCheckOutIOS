//
//  ItemNew.swift
//  CheckOut
//
//  Created by SCIS on 5/22/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper


class Item: Mappable{
    
    var id: Int?
    var name: String?
    var category: String?
    var photoUrl: String?
    var price: Double?
    var image: UIImage?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        category <- map["category"]
        photoUrl <- map["photoUrl"]
        price <- map["price"]
    }
    
    

}
