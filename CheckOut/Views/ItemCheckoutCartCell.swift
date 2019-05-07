//
//  CheckOutCollectionViewCell.swift
//  CheckOut
//
//  Created by SCIS on 5/2/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import UIKit

class ItemCheckoutCartCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemQty: UILabel!
    
    var item: Item!
    
    let cart = CartManager.cart;
    
    func setItem(item: Item){
        self.item = item
        let qty = cart.value[item.id]
        self.itemImage.clipsToBounds = true
        self.itemName.text = item.name
        self.itemPrice.text = "$"+String(item.price)
        self.itemQty.text = String(qty!)+" units"
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let qty = cart.value[item.id]
        self.itemImage.image = item.image2
        self.itemImage.layer.cornerRadius = 5
        self.itemImage.clipsToBounds = true
        self.itemName.text = item.name
        self.itemPrice.text = "$"+String(item.price)
        self.itemQty.text = String(qty!)+" units"
        
        
    }
    
}
