//
//  CartSingleton.swift
//  CheckOut
//
//  Created by SCIS on 5/4/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import Foundation

/*
    CartSingleton is responsible of share the only cart as well as the methods to operate with the cart
 */
class CartManager{
    
    static let shared = CartManager()
    
    var value: [Int: Int] = [:]
    
    private init(){
    }
    
    func change(key: Int, number: Int){
        value[key] = number
        self.value = self.value.filter{$0.value > 0}
    }
    
    func clean(){
        self.value = [:]
    }
    
    func toPurchaseLinePost() -> [PurchaseLinePost]{
        var lines: [PurchaseLinePost] = []
        for (item) in value {
            let line = PurchaseLinePost(itemId: item.key)
            lines.append(line)
        }
        return lines
    }
}
