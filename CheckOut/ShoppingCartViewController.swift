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
    
    let cart = CartSingleton.cart
    let data = ModelManager.data
    
    var sections:[String] = []
    var itemsBySection: [Int: [Item]] = [:]
    var actualItemsBySection: [Int: [Item]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data.fetchItems()
        data.fetchBanners()
        addItemsToSections(items: data.items)
        
        pageBannerController.currentPage = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemTableView.reloadData()
        
        print(cart.value)
    }
    
    @IBAction func pageBannerControlledTapped(_ sender: Any) {
        bannerCollectionView.scrollToItem(at: IndexPath(row: pageBannerController.currentPage, section: 0), at: .right, animated: false)
    }
    func addItemsToSections(items: [Item]){
        for item in items{
            let type = item.type
            let index = sections.index(of: type)
            
            if (index == nil){
                itemsBySection[sections.count] = [item]
                sections.append(type)
            }
            else
            {
                var aux = itemsBySection[index!]
                aux!.append(item)
                itemsBySection[index!] = aux
            }
        }
        actualItemsBySection = itemsBySection

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ShoppingCartViewController: UITableViewDataSource, UITableViewDelegate{
    
    //Sections
    func numberOfSections(in tableView: UITableView) -> Int {

        return actualItemsBySection.count
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
        return actualItemsBySection[section]!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemViewCell
  
        let item: Item = actualItemsBySection[indexPath.section]![indexPath.row]
        
        cell.setItem(item: item)
        
        if let stock = cart.value[item.id]{
            cell.stock = stock
        }
        else{
            cell.stock = 0
        }
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
}

extension ShoppingCartViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageBannerController.numberOfPages = data.banners.count
        return data.banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! ItemCollectionViewCell
        let banner: Banner = data.banners[indexPath.row]
        cell.banner = banner
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: bannerCollectionView.bounds.width - 10, height: bannerCollectionView.bounds.height)
    }
    
}

extension ShoppingCartViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageBannerController.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageBannerController.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

extension ShoppingCartViewController: ItemCellDelegate {
    func didTapAddButton(itemId: Int, indexPath: IndexPath) {
        cart.change(key: itemId, number: 1)
        itemTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
    
    func didTapPlusButton(itemId: Int ,indexPath: IndexPath) {
        if let stock = cart.value[itemId]{
            if(stock < 10){
                cart.change(key: itemId, number: stock + 1)
            }
        }
        itemTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
    
    func didTapMinusButton(itemId: Int,indexPath: IndexPath) {
        if let stock = cart.value[itemId]{
            if(stock > 0){
                cart.change(key: itemId, number: stock - 1)
            }
        }
        itemTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
}


extension ShoppingCartViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else{
            actualItemsBySection = itemsBySection
            itemTableView.reloadData()
            return
        }
        for (index, section) in itemsBySection {
            actualItemsBySection[index] = section.filter({ (item) -> Bool in String(item.name).lowercased().contains(searchText.lowercased())
            })
        }
        itemTableView.reloadData()
    }
}

