//
//  PurchaseViewCell.swift
//  CheckOut
//
//  Created by SCIS on 5/25/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import UIKit

class PurchaseViewCell: UITableViewCell {
    
    @IBOutlet weak var purchaseDateLabel: UILabel!
    @IBOutlet weak var purchaseTotalAmountLabel: UILabel!
    var purchase: Purchase!
    
    func setPurchase(purchase: Purchase){
        self.purchase = purchase
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let myDateString = formatter.string(from: purchase.date!) // string purpose I add here
        purchaseDateLabel.text = myDateString
        purchaseTotalAmountLabel.text = "$100"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
