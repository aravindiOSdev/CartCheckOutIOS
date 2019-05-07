//
//  ModelManager.swift
//  CheckOut
//
//  Created by SCIS on 5/4/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import Foundation

/*
    ModelManager is responsible of get, save, and share the data that should be obtained from an api
 */
class ModelManager{
    
    static let data = ModelManager()
    
    var items: [Item] = []
    var itemsById: [Int: Item] = [:]
    var banners: [Banner] = []
    
    private init(){
    }
    
    func fetchItems()
    {
        items = getItems()
        addItemsById(items: items)
    }
    
    func fetchBanners()
    {
        banners = getBanners()
    }
    
    private func getItems() -> [Item]{
        
        let item1 = Item(id: 1, name: "Watermelon",type: "Fruits",image: #imageLiteral(resourceName: "Watermelon"), image2: #imageLiteral(resourceName: "Watermelon-2"),price: 3000)
        let item2 = Item(id: 2, name: "Orange",type: "Fruits",image: #imageLiteral(resourceName: "Grapefruit"), image2: #imageLiteral(resourceName: "Grapefruit-2"), price: 1)
        let item3 = Item(id: 3, name: "Kiwi",type: "Fruits",image: #imageLiteral(resourceName: "kiwi"), image2: #imageLiteral(resourceName: "Kiwi-2"),price: 200)
        let item4 = Item(id: 4,name: "Avocado",type: "Veggie",image: #imageLiteral(resourceName: "Avocado"), image2: #imageLiteral(resourceName: "Avocado"),price: 310.01)
        let item5 = Item(id: 5,name: "Cucumber",type: "Veggie",image: #imageLiteral(resourceName: "Cucumber"), image2: #imageLiteral(resourceName: "Cucumber"),price: 30005)
        
        return [item1, item2, item3, item4, item5]
    }
    
    private func getBanners() -> [Banner]{
        let banner1 = Banner(itemName: "Banana",title: "Subtitle",image: #imageLiteral(resourceName: "Banner-1"))
        let banner2 = Banner(itemName: "Oranges",title: "Fruits",image: #imageLiteral(resourceName: "Banner-2"))
        let banner3 = Banner(itemName: "Cucumbers",title: "Fruits",image: #imageLiteral(resourceName: "Banner-3"))
        let banner4 = Banner(itemName: "Kiwi",title: "Fruits",image: #imageLiteral(resourceName: "Banner-4"))
        
        return [banner1, banner2, banner3, banner4]
        
    }
    
    private func addItemsById(items: [Item]){
        for item in items{
            if(itemsById[item.id] == nil)
            {
                itemsById[item.id] = item
            }
        }
    }
}
