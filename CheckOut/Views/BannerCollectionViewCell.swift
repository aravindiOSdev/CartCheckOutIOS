//
//  ItemCollectionViewCell.swift
//  CheckOut
//
//  Created by SCIS on 4/19/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var bannerTitle: UILabel!
    @IBOutlet weak var bannerItemName: UILabel!
    
    var banner: Banner!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        self.bannerImage.image = banner.image
        self.bannerTitle.text = banner.title
        self.bannerItemName.text = banner.itemName
        
    }
    
    
    
    
    
}
