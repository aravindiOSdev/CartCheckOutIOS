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
    let modelManager = ModelManager.data
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        modelManager.fetchAllPurchases{ (purchases, error) in
            print(purchases ?? "")
        }
    }
}

extension PurchaseHistoryViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath) as! PurchaseViewCell
        return cell
    }
    
}
