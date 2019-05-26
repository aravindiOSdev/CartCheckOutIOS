//
//  ItemViewCell.swift
//  CheckOut
//
//  Created by SCIS on 4/19/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import UIKit
import Kingfisher

protocol ItemCheckoutCellDelegate{
    
    func didTapPlusButton(itemId: Int, indexPath: IndexPath)
    func didTapMinusButton(itemId: Int ,indexPath: IndexPath)
    func didTapAddButton(itemId: Int, indexPath: IndexPath)
}

class ItemShoppingCartCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var cellTitle: UILabel!
    
    @IBOutlet weak var cellSubtitle: UILabel!
    
    @IBOutlet weak var addContainer: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var itemQtyContainer: UIView!
    
    @IBOutlet weak var labelQty: UILabel!
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        delegate?.didTapPlusButton(itemId: item.id!, indexPath: indexPath)
    }
    
    @IBAction func minusButtonTapped(_ sender: Any) {
        delegate?.didTapMinusButton(itemId: item.id!,indexPath: indexPath)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        delegate?.didTapAddButton(itemId: item.id!, indexPath: indexPath)
    }
    
    var delegate: ItemCheckoutCellDelegate?
    var item: Item!
    var stock: Int = 0
    var indexPath: IndexPath!
    var section: Int!
    let defaultImage: UIImage = #imageLiteral(resourceName: "image")

    func setItemNew(item: Item){
        self.item = item
        self.setImage(urlString: item.photoUrl ?? "")
    }
    
    func setStock(stock: Int){
        self.stock = stock
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setImage(urlString: item.photoUrl ?? "")
        self.cellTitle.text = item.name
        self.cellSubtitle.text = "$"+String(item.price!)
        
        if(stock==0){
            itemQtyContainer.isHidden = true
            addButton.isHidden = false
        }
        else if(stock>0){
            itemQtyContainer.isHidden = false
            addButton.isHidden = true
            labelQty.text = String(stock)
        }
        
        itemImage?.layer.cornerRadius = (itemImage?.bounds.height)! / 2
        itemImage?.clipsToBounds = true
        
        addButton.layer.cornerRadius = 20
        addButton.clipsToBounds = true
        
        itemQtyContainer.layer.cornerRadius = 20
        itemQtyContainer.clipsToBounds = true
        
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.purple.cgColor
        
        itemQtyContainer.layer.borderWidth = 0.5
        itemQtyContainer.layer.borderColor = UIColor.lightGray.cgColor
        
        addButton.backgroundColor = UIColor.white
        addButton.tintColor = UIColor.purple
        
        
    }
    
    func setImage(urlString: String){
        
        let url = URL(string: urlString)
        itemImage.kf.indicatorType = .activity
        itemImage.kf.setImage(
            with: url,
            placeholder: defaultImage,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])

    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
