//
//  ViewController.swift
//  CheckOut
//
//  Created by SCIS on 4/19/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var sections:[String] = []
    
    var itemsInSections:[[Item]] = []
    
    var items: [Item] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        items = getData();
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

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsInSections[section].count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemViewCell
        cell.textLabel?.text = itemsInSections[indexPath.section][indexPath.row].name
        cell.detailTextLabel?.text = String( itemsInSections[indexPath.section][indexPath.row].price)

        cell.imageView?.image = itemsInSections[indexPath.section][indexPath.row].image
        cell.imageView?.layer.cornerRadius = (cell.imageView?.bounds.height)! / 2
        cell.imageView?.clipsToBounds = true
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
        
    }
    
    func getData() -> [Item]{
        let item1 = Item(name: "Watermelon",type: "Fruits",image: #imageLiteral(resourceName: "Watermelon"),price: 30)
        let item2 = Item(name: "Orange",type: "Fruits",image: #imageLiteral(resourceName: "Grapefruit"), price: 30)
        let item3 = Item(name: "Kiwi",type: "Fruits",image: #imageLiteral(resourceName: "kiwi"),price: 30)
        let item4 = Item(name: "Avocado",type: "Veggie",image: #imageLiteral(resourceName: "Avocado"),price: 30)
        let item5 = Item(name: "Cucumber",type: "Veggie",image: #imageLiteral(resourceName: "Cucumber"),price: 30)
        
        let items: [Item] = [item1, item2, item3, item4, item5]
        return items
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

