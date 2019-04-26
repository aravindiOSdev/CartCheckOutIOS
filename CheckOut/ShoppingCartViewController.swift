//
//  ViewController.swift
//  CheckOut
//
//  Created by SCIS on 4/19/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var pageBannerController: UIPageControl!
    
    var sections:[String] = []
    
    var itemsInSections:[[Item]] = []
    
    var items: [Item] = []
    
    var banners: [UIImage] = [#imageLiteral(resourceName: "Banner-1"),#imageLiteral(resourceName: "Banner-2"),#imageLiteral(resourceName: "Banner-3"),#imageLiteral(resourceName: "Banner-4")]
    
    var banners2: [Banner] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        items = getItems()
        banners2 = getBanners()
        
        addItemsToSections(items: items)
    }
    
    func getItems() -> [Item]{
        let item1 = Item(name: "Watermelon",type: "Fruits",image: #imageLiteral(resourceName: "Watermelon"), image2: #imageLiteral(resourceName: "Watermelon-2"),price: 30)
        let item2 = Item(name: "Orange",type: "Fruits",image: #imageLiteral(resourceName: "Grapefruit"), image2: #imageLiteral(resourceName: "Grapefruit-2"), price: 30)
        let item3 = Item(name: "Kiwi",type: "Fruits",image: #imageLiteral(resourceName: "kiwi"), image2: #imageLiteral(resourceName: "Kiwi-2"),price: 30)
        let item4 = Item(name: "Avocado",type: "Veggie",image: #imageLiteral(resourceName: "Avocado"), image2: #imageLiteral(resourceName: "Avocado"),price: 30)
        let item5 = Item(name: "Cucumber",type: "Veggie",image: #imageLiteral(resourceName: "Cucumber"), image2: #imageLiteral(resourceName: "Cucumber"),price: 30)
        
        return [item1, item2, item3, item4, item5]
    }
    
    func getBanners() -> [Banner]{
        let banner1 = Banner(title: "Banana",subtitle: "Subtitle",image: #imageLiteral(resourceName: "Banner-1"))
        let banner2 = Banner(title: "Oranges",subtitle: "Fruits",image: #imageLiteral(resourceName: "Banner-2"))
        let banner3 = Banner(title: "Cucumbers",subtitle: "Fruits",image: #imageLiteral(resourceName: "Banner-3"))
        let banner4 = Banner(title: "Kiwi",subtitle: "Fruits",image: #imageLiteral(resourceName: "Banner-4"))
        
        return [banner1, banner2, banner3, banner4]
        
    }
    
    func addItemsToSections(items: [Item]){
        for item in items{
            let type = item.type
            let index = sections.index(of: type)
            if (index == nil){
                sections.append(type)
                itemsInSections.append([item])
            }
            else
            {
                itemsInSections[index!].append(item)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ShoppingCartViewController: UITableViewDataSource, UITableViewDelegate{
    
    //Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
        
    }
    //Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsInSections[section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemViewCell
        cell.textLabel?.text = itemsInSections[indexPath.section][indexPath.row].name
        cell.detailTextLabel?.text = String( itemsInSections[indexPath.section][indexPath.row].price)
        cell.imageView?.image = itemsInSections[indexPath.section][indexPath.row].image
    
        return cell
    }
}

extension ShoppingCartViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath)
        
        return cell
        
    }
}

