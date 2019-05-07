//
//  CheckoutCartViewController.swift
//  CheckOut
//
//  Created by SCIS on 5/4/19.
//  Copyright © 2019 Jartola. All rights reserved.
//

import UIKit

class CheckoutCartViewController: UIViewController {

    @IBOutlet weak var cartCollectionView: UICollectionView!

    let cart = CartSingleton.cart
    let data = ModelManager.data
    let pickerData = [1,2,3,4,5,6,7,8,9,10]
    
    var toolBar = UIToolbar()
    var selectedItemId: Int = -1
    var qtyPickerSelected: Int?
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var qtyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutButton.layer.cornerRadius = 20
        checkoutButton.clipsToBounds = true
        qtyPicker.isHidden = true
        qtyPicker.showsSelectionIndicator = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshAmount()
        if(cart.value.isEmpty){
            checkoutButton.isEnabled = false
        }
        else{
            checkoutButton.isEnabled = true
        }
    }
    
    @IBAction func checkoutButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Susccesfuly Checkout", message: "We have send the reciept to your email address", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: checkoutDone)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func checkoutDone(alert: UIAlertAction){
        cart.clean()
        self.navigationController!.popViewController(animated: true)
    }
    
    func refreshAmount(){
        var totalAmount: Double = 0
        for (itemId, qty) in cart.value{
            let lineAmount = Double(qty) * data.itemsById[itemId]!.price
            totalAmount += lineAmount
        }
        totalAmountLabel.text = "$" + String(totalAmount)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CheckoutCartViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cart.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCollectionCell", for: indexPath) as! CheckOutCollectionViewCell
        let itemId = Array(cart.value.keys)[indexPath.row]
        let item: Item = data.itemsById[itemId]!
        cell.setItem(item: item)

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = cartCollectionView.bounds.width/2 - 5
        let height = width*1.3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = cartCollectionView.cellForItem(at: indexPath) as! CheckOutCollectionViewCell
        selectedItemId = cell.item.id
        let qty = cart.value[cell.item.id]
        let index = pickerData.index(of: qty!)
        
        qtyPicker.selectRow(index!, inComponent: 0, animated: false)
        qtyPicker.isHidden = false
        displayToolBarForPicker()
    }
    
    func displayToolBarForPicker(){
        toolBar.removeFromSuperview()
        toolBar = UIToolbar.init(frame: CGRect.init(x: qtyPicker.frame.origin.x, y: qtyPicker.frame.origin.y, width: qtyPicker.frame.width, height: 50))
        toolBar.barStyle = .default
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    
    @objc func doneButtonTapped(){
        qtyPicker.isHidden = true
        toolBar.removeFromSuperview()
        
        cart.value[selectedItemId] = qtyPickerSelected
        
        cartCollectionView.reloadData()
        refreshAmount()
    }
    
}

extension CheckoutCartViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        qtyPickerSelected = pickerData[row]
    }
    
    
}

