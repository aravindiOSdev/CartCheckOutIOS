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
        
        
        self.setImage(urlString: banner.photoUrl ?? "")
        self.bannerTitle.text = banner.description
        self.bannerItemName.text = banner.name
        
    }
    func setImage(urlString: String){
        
        let url = URL(string: urlString)
        bannerImage.kf.indicatorType = .activity
        bannerImage.kf.setImage(
            with: url,
            placeholder: #imageLiteral(resourceName: "image"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
    }
    
    
    
    
}
