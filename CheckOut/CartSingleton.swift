//
//  CartSingleton.swift
//  CheckOut
//
//  Created by SCIS on 5/4/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import Foundation

class CartSingleton{
    
    static let cart = CartSingleton()
    
    var value: [Int: Int] = [:]
    
    private init(){
        print("Im Born")
    }
    
    func change(key: Int, number: Int)
    {
        value[key] = number
        self.value = self.value.filter{$0.value > 0}
    }
    
    func clean()
    {
        self.value = [:]
    }
}
