//
//  PurchaseViewCell.swift
//  CheckOut
//
//  Created by SCIS on 5/25/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import UIKit

protocol PurchaseDetailDelegate{
    
    func didTapDetailsButton(indexPath: IndexPath)
}

class PurchaseViewCell: UITableViewCell {
    
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var purchaseDateLabel: UILabel!
    @IBOutlet weak var purchaseTotalAmountLabel: UILabel!
    var purchase: Purchase!
    var delegate: PurchaseDetailDelegate?
    var indexPath: IndexPath!
    
    @IBAction func didTapDetailsButton(_ sender: Any) {
        delegate?.didTapDetailsButton(indexPath: indexPath)
    }
    
    
    
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
        
        
        detailButton.layer.cornerRadius = 20
        detailButton.clipsToBounds = true
        detailButton.layer.borderWidth = 1
        detailButton.layer.borderColor = UIColor.purple.cgColor
        detailButton.backgroundColor = UIColor.white
        detailButton.tintColor = UIColor.purple
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
