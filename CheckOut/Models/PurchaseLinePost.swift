//
//  PurchaseLinePost.swift
//  CheckOut
//
//  Created by SCIS on 5/28/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import Foundation
import ObjectMapper

class PurchaseLinePost: Mappable{
    
    var itemId: Int?
    var qty: Int?
    
    required init?(map: Map) {
    }
    
    init(itemId: Int){
        self.itemId = itemId
        self.qty = CartManager.shared.value[itemId]
    }
    
    func mapping(map: Map) {
        itemId <- map["product_id"]
        qty <- map["quantity"]
    }
    
}
