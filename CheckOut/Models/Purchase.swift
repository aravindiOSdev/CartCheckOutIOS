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
    
    var date: Date?
    var purchaseLines: [PurchaseLine]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        /*let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let dateString = map["date"].currentValue as? String,
            
            let _date = dateFormatter.date(from: dateString) {
            date = _date
        }*/
        date <- (map["date"], CustomDateTransform())
        purchaseLines <- map["products"]
    }
    
    func convertToCart() -> [Int:Int]
    {
        var cart: [Int:Int] = [:]
        for purchaseLine in purchaseLines ?? []{
            cart[purchaseLine.item!.id!] = purchaseLine.qty
        }
        return cart
    }
    
}
