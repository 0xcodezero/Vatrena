//
//  CartsViewController.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 7/29/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit

protocol CartActionsDelegate {
    func confirmRequestedCartItems()
    func cartItemsUpdated()
    func continueClosingCartViewWithDecision(confirmed: Bool)
}

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var cartDelegate : CartActionsDelegate?
    
    @IBOutlet weak var cartItemsTableView: UITableView!
    @IBOutlet weak var blurViewContainer: UIView!
    
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var totalOrderValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurViewContainer.addSubview(blurEffectView)
        
        cartItemsTableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
        
        adjustViewsValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
    //MARK: - TableView DataSource & Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return VTCartManager.sharedInstance.cartItems?.count ?? 0
    }
    
    
    final let REUSE_IDENTIFIER = "product-cell"
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = cartItemsTableView.dequeueReusableCell(withIdentifier:REUSE_IDENTIFIER ) as! ProductTableViewCell
            let productItem = VTCartManager.sharedInstance.cartItems?[indexPath.row]
            // set the text from the data model
            cell.selectionStyle = .none
            cell.setProductItem(productItem!)
            cell.addItemButton.tag = indexPath.row
            cell.removeItemButton.tag =  indexPath.row
            cell.showDetailsButton.tag = indexPath.row
            
            return cell
    }
    
    
    @IBAction func closeCartAction(_ sender: UIButton) {
        cartDelegate?.continueClosingCartViewWithDecision(confirmed: false)
    }
    
    @IBAction func updateCartItemsAction(_ sender: UIButton) {
        
        let row = sender.tag
        let item = VTCartManager.sharedInstance.cartItems?[row]
        VTCartManager.sharedInstance.updateItemInsideCart(store: VTCartManager.sharedInstance.selectedStore, item: item!)
        
        cartItemsTableView.reloadData()
        adjustViewsValues()
        
        if (VTCartManager.sharedInstance.cartItems?.count ?? 0) == 0 {
            cartDelegate?.continueClosingCartViewWithDecision(confirmed: false)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func adjustViewsValues(){
        storeLabel.text = VTCartManager.sharedInstance.selectedStore?.name
        totalOrderValueLabel.text = "\(VTCartManager.sharedInstance.calclateTotalOrderCost()) ريال"
    }
    
    @IBAction func confirmStartingOrderAction(_ sender: UIButton) {
        cartDelegate?.confirmRequestedCartItems()
    }

}
