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
    
    @IBOutlet weak var itemTableView: UITableView!
    
    
    var sections:[String] = []

    var itemsInSections:[[Item]] = []
    
    var actualItemsInSections:[[Item]] = []
    
    var items: [Item] = []
    
    var cart: [Int: Int] = [:]
    
    
    var banners: [Banner] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        items = getItems()
        banners = getBanners()
        
        addItemsToSections(items: items)
        actualItemsInSections = itemsInSections
    }
    
    func getItems() -> [Item]{
        print("hello")

        let item1 = Item(id: 1, name: "Watermelon",type: "Fruits",image: #imageLiteral(resourceName: "Watermelon"), image2: #imageLiteral(resourceName: "Watermelon-2"),price: 30)
        let item2 = Item(id: 2, name: "Orange",type: "Fruits",image: #imageLiteral(resourceName: "Grapefruit"), image2: #imageLiteral(resourceName: "Grapefruit-2"), price: 30)
        let item3 = Item(id: 3, name: "Kiwi",type: "Fruits",image: #imageLiteral(resourceName: "kiwi"), image2: #imageLiteral(resourceName: "Kiwi-2"),price: 30)
        let item4 = Item(id: 4,name: "Avocado",type: "Veggie",image: #imageLiteral(resourceName: "Avocado"), image2: #imageLiteral(resourceName: "Avocado"),price: 30)
        let item5 = Item(id: 5,name: "Cucumber",type: "Veggie",image: #imageLiteral(resourceName: "Cucumber"), image2: #imageLiteral(resourceName: "Cucumber"),price: 30)
        
        return [item1, item2, item3, item4, item5]
    }
    
    func getBanners() -> [Banner]{
        let banner1 = Banner(itemName: "Banana",title: "Subtitle",image: #imageLiteral(resourceName: "Banner-1"))
        let banner2 = Banner(itemName: "Oranges",title: "Fruits",image: #imageLiteral(resourceName: "Banner-2"))
        let banner3 = Banner(itemName: "Cucumbers",title: "Fruits",image: #imageLiteral(resourceName: "Banner-3"))
        let banner4 = Banner(itemName: "Kiwi",title: "Fruits",image: #imageLiteral(resourceName: "Banner-4"))
        
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
        

        //let actualSections = actualItemsInSections.filter({ (items) -> Bool in !items.isEmpty
        //})
            
        
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //Header White background & Custom Font
        
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
        myLabel.font = UIFont.boldSystemFont(ofSize: 18)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        headerView.addSubview(myLabel)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sections[section]
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.backgroundView?.backgroundColor = UIColor.white
            
                header.textLabel?.textColor = UIColor.black
        

        }
    }
    //Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actualItemsInSections[section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemViewCell
  
        let item: Item = actualItemsInSections[indexPath.section][indexPath.row]
        print(item.name)
        cell.setItem(item: item)
        
        if let stock = cart[item.id]{
            cell.stock = stock
        }
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
}

extension ShoppingCartViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! ItemCollectionViewCell
        let banner: Banner = banners[indexPath.row]
        cell.banner = banner
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: bannerCollectionView.bounds.width - 10, height: bannerCollectionView.bounds.height)
    }
    
}

extension ShoppingCartViewController: ItemCellDelegate {
    func didTapAddButton(itemId: Int, indexPath: IndexPath) {
        cart[itemId] = 1
        
        itemTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
    
    func didTapPlusButton(itemId: Int ,indexPath: IndexPath) {
        if let stock = cart[itemId]{
            if(stock < 10){
                cart[itemId] = stock+1
            }
        }
        itemTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
    
    func didTapMinusButton(itemId: Int,indexPath: IndexPath) {
        if let stock = cart[itemId]{
            if(stock > 0){
                cart[itemId] = stock-1
            }
        }
        itemTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
}


extension ShoppingCartViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else{
            actualItemsInSections = itemsInSections
            itemTableView.reloadData()
            return
        }
        for (index, section) in actualItemsInSections.enumerated(){
            actualItemsInSections[index] = section.filter({ (item) -> Bool in String(item.name).lowercased().contains(searchText.lowercased())
            })
            
        }
        itemTableView.reloadData()
    }
}

