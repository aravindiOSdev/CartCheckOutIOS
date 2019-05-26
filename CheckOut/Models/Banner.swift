//
//  Banner.swift
//  CheckOut
//
//  Created by SCIS on 5/25/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper


class Banner: Mappable{
    
    var name: String?
    var description: String?
    var photoUrl: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        description <- map["description"]
        photoUrl <- map["photoUrl"]
    }
    
    
    
}

