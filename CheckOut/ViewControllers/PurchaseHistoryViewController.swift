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
    var vSpinner : UIView?
    var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        showSpinner(onView: self.view)
        modelManager.fetchAllPurchases{ (purchases, error) in
            self.purchases = purchases ?? []
            self.removeSpinner()
            self.purchaseTableView.reloadData()
            
        }
    }
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init()
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let checkoutCartViewController = segue.destination as! CheckoutCartViewController
        
        checkoutCartViewController.readOnly = true
        checkoutCartViewController.purchaseCart = purchases[selectedIndexPath!.row].convertToCart()
    }
}

extension PurchaseHistoryViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath) as! PurchaseViewCell
        cell.setPurchase(purchase: purchases[indexPath.row])
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPurchase = self.purchases[indexPath.row]
    }
    
}

extension PurchaseHistoryViewController: PurchaseDetailDelegate {
    func didTapDetailsButton(indexPath: IndexPath) {
        selectedIndexPath = indexPath
        self.performSegue(withIdentifier: "detailPurchase", sender: self)
    }
}
