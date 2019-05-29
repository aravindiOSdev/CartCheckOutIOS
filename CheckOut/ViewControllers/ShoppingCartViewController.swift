//
//  ViewController.swift
//  CheckOut
//
//  Created by SCIS on 4/19/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    
    let cart = CartManager.shared
    let modelManager = ModelManager.shared
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    @IBOutlet weak var itemTableView: UITableView!
    
    var sections:[String] = []
    var itemsBySection: [Int: [Item]] = [:]
    var actualItemsBySection: [Int: [Item]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        modelManager.fetchAllItems { (items, error) in
            self.addItemsToSectionsNew(items: items ?? [])
            self.itemTableView.reloadData()
        }
        
        modelManager.fetchAllBanners { (banners, error) in
            print(banners![0].name!)
            self.bannerCollectionView.reloadData()
            
        }
        
        bannerPageControl.currentPage = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemTableView.reloadData()
    }
    
    func addItemsToSectionsNew(items: [Item]){
        for item in items{
        let type = item.category!.uppercased()
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
}

extension ShoppingCartViewController: UITableViewDataSource, UITableViewDelegate{
    
    //Sections
    func numberOfSections(in tableView: UITableView) -> Int {

        return actualItemsBySection.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //Header White background & Custom Font
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
        headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        headerView.addSubview(headerLabel)
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemShoppingCartCell
  
        //let item: Item = actualItemsBySection[indexPath.section]![indexPath.row]
        let itemNew: Item = actualItemsBySection[indexPath.section]![indexPath.row]
        //cell.setItem(item: item)
        cell.setItemNew(item: itemNew)
        
        if let stock = cart.value[itemNew.id!]{
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
        bannerPageControl.numberOfPages = modelManager.banners.count
        return modelManager.banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannerCollectionViewCell
        let banner: Banner = modelManager.banners[indexPath.row]
        cell.banner = banner
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: bannerCollectionView.bounds.width - 10, height: bannerCollectionView.bounds.height)
    }
    
}

extension ShoppingCartViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        bannerPageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        bannerPageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

extension ShoppingCartViewController: ItemCheckoutCellDelegate {
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
            actualItemsBySection[index] = section.filter({ (item) -> Bool in String(item.name!).lowercased().contains(searchText.lowercased())
            })
        }
        itemTableView.reloadData()
    }
}

