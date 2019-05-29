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
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        purchaseDateLabel.text = formatter.string(from: purchase.date!)
        purchaseTotalAmountLabel.text = "$"+String(purchase.amount())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
