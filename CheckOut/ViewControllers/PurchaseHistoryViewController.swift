//
//  PurchaseHistoryViewController.swift
//  CheckOut
//
//  Created by SCIS on 5/25/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import UIKit

class PurchaseHistoryViewController: UIViewController {

    @IBOutlet weak var purchaseTableView: UITableView!
    let modelManager = ModelManager.shared
    var purchases: [Purchase] = []
    var selectedPurchase: Purchase?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        modelManager.fetchAllPurchases{ (purchases, error) in
            print(purchases ?? "")
            self.purchases = purchases ?? []
            self.purchaseTableView.reloadData()
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let checkoutCartViewController = segue.destination as! CheckoutCartViewController
        
        checkoutCartViewController.readOnly = true
        checkoutCartViewController.purchaseCart = purchases[(purchaseTableView.indexPathForSelectedRow?.row)!].convertToCart()
    }
}

extension PurchaseHistoryViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath) as! PurchaseViewCell
        cell.setPurchase(purchase: purchases[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPurchase = self.purchases[indexPath.row]
    }
    
}
