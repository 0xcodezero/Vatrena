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
    func continueClosingCartViewWithoutDecision()
}

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var cartDelegate : CartActionsDelegate?
    
    @IBOutlet weak var cartItemsTableView: UITableView!
    @IBOutlet weak var blurViewContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurViewContainer.addSubview(blurEffectView)
        
        cartItemsTableView.contentInset = UIEdgeInsetsMake(40, 0, 20, 0);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
    //MARK: - TableView DataSource & Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3 // Cart Description, TableView Items, Cart Checkout
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 1:
            return VTCartManager.sharedInstance.cartItems?.count ?? 0
        default:
            return 0
        }
    }
    
    
    final let REUSE_IDENTIFIER = "product-cell"
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
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
        cartDelegate?.continueClosingCartViewWithoutDecision()
    }
    @IBAction func updateCartItemsAction(_ sender: UIButton) {
        
        let row = sender.tag
        let item = VTCartManager.sharedInstance.cartItems?[row]
        VTCartManager.sharedInstance.updateItemInsideCart(store: VTCartManager.sharedInstance.selectedStore, item: item!)
        
        cartItemsTableView.reloadData()
        
        if (VTCartManager.sharedInstance.cartItems?.count ?? 0) == 0 {
            cartDelegate?.continueClosingCartViewWithoutDecision()
        }
        
    }

}
