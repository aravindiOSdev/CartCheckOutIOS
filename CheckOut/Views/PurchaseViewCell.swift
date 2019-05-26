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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
