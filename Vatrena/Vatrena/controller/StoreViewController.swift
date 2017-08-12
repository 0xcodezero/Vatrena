//
//  StoreViewController.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 7/30/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit
import PKHUD
import Firebase


protocol StoreDelegate {
    func confirmOrderFromStore()
}

class StoreViewController: UIViewController  , UITableViewDelegate, UITableViewDataSource, ProductDetailsDelegate, CartActionsDelegate {

    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var segmentContainerView: UIView!
    @IBOutlet weak var storeTitleLabel: UILabel!
    @IBOutlet weak var blockingView: UIView!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var numberOfCartItemsLabel: UILabel!
    @IBOutlet weak var deliverButton: UIButton!
    
    var store : VTStore!
    
    var storeDelegate : StoreDelegate?
    var productDetailsViewController : ProductDetailsViewController!
    var cartDetailsViewController : CartViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMarektsSegmentView()
        storeTitleLabel.text = store.name
        
        productsTableView.contentInset = ((store.itemGroups?.count) ?? 0 < Constants.MINIMUM_NUNMBER_OF_SECTIONS_TO_SHOW_SEGMENT ) ?  UIEdgeInsetsMake(0, 0, 40, 0) : UIEdgeInsetsMake(40, 0, 40, 0)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blockingView.addSubview(blurEffectView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareCartView(animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Views Customization
    func setupMarektsSegmentView () {
        
        if ((store.itemGroups?.count) ?? 0 < Constants.MINIMUM_NUNMBER_OF_SECTIONS_TO_SHOW_SEGMENT ) { // Two sections are sufficient for showing the segment view
            self.segmentContainerView.alpha = 0.0
            return
        }
        
        let segment = NLSegmentControl(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        segment.segments = store.itemGroups?.map({ return $0.name ?? ""}) ?? []
        segment.segmentWidthStyle = .dynamic
        segment.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        segment.selectionIndicatorHeight = 4.0
        segment.selectionIndicatorColor = .white
        segment.selectionIndicatorPosition = .bottom
        segment.enableVerticalDivider = true
        segment.verticalDividerWidth = 1
        segment.verticalDividerInset = 12
        
        segment.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0), NSForegroundColorAttributeName: UIColor.white]
        segment.selectedTitleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0), NSForegroundColorAttributeName: UIColor.white]
        
        segment.indexChangedHandler = { (index) in
            if((self.store.itemGroups?[index].items?.count ?? 0) > 0){
                self.productsTableView.scrollToRow(at: IndexPath(row: 0, section: index) , at: .top, animated: true)
            }
        }
        self.segmentContainerView.alpha = 1.0
        self.segmentContainerView.addSubview(segment)
        segment.reloadSegments()
    }
    
    func prepareCartView(animated: Bool){
        
        UIView.transition(with: numberOfCartItemsLabel,
                          duration: animated ? 0.2 : 0.0,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.numberOfCartItemsLabel.text = "\(VTCartManager.sharedInstance.calclateTotalNumberOfCartItems())"
            }, completion: nil)
        
        
        UIView.animate(withDuration: 0.4, animations: { [unowned self] in
            self.deliverButton.frame.origin.x = ((VTCartManager.sharedInstance.cartItems?.count ?? 0 ) == 0) ? self.cartButton.frame.origin.x : self.cartButton.frame.origin.x - 70
            
            if (VTCartManager.sharedInstance.cartItems?.count ?? 0 ) == 0 {
                self.numberOfCartItemsLabel.alpha = 0.0
                self.cartButton.alpha = 0.0
                self.deliverButton.alpha = 0.0
            }else{
                self.numberOfCartItemsLabel.alpha = 1.0
                self.cartButton.alpha = 1.0
                self.deliverButton.alpha = 1.0
            }
        })
    }
    
    
    //MARK: - TableView DataSource & Delegate
    final let REUSE_IDENTIFIER = "product-cell"
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return store.itemGroups?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.itemGroups?[section].items?.count ?? 0
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailsForProductItem(atIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = productsTableView.dequeueReusableCell(withIdentifier:REUSE_IDENTIFIER ) as! ProductTableViewCell
        let productItem = store.itemGroups?[indexPath.section].items?[indexPath.row]
        // set the text from the data model
        cell.selectionStyle = .none
        cell.setProductItem(productItem!)
        cell.addItemButton.tag = (indexPath.section * Constants.GROUP_OFFSET) + indexPath.row
        cell.removeItemButton.tag = (indexPath.section * Constants.GROUP_OFFSET) + indexPath.row
        cell.showDetailsButton.tag = (indexPath.section * Constants.GROUP_OFFSET) + indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.storeHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: Constants.storeHeaderHeight))
        view.backgroundColor = UIColor.clear
        
        let headerLable = UILabel(frame: CGRect(x: 10  , y: 10, width: self.view.frame.size.width - 20 , height: Constants.storeHeaderHeight - 20))
        headerLable.text = store.itemGroups?[section].name
        headerLable.textAlignment = .right
        headerLable.font = UIFont.systemFont(ofSize: 24)
        headerLable.textColor = UIColor.white
        view.addSubview(headerLable)
        
        return view
    }
    
    //MARK: - IBAction Handlers
    
    @IBAction func tapDoneAction(_ sender: UITapGestureRecognizer) {
        hideDetailsViewController()
    }
    
    
    @IBAction func updateItemInsideCartAction(_ sender: UIButton) {
        let section = sender.tag / Constants.GROUP_OFFSET
        let row = sender.tag % Constants.GROUP_OFFSET
        let item = store.itemGroups?[section].items?[row]
        
        VTCartManager.sharedInstance.updateItemInsideCart(store: store, item: item!)
        
        self.prepareCartView(animated: true)
    }
    
    @IBAction func showDetailsForProductAction(_ sender: UIButton) {
        let section = sender.tag / Constants.GROUP_OFFSET
        let row = sender.tag % Constants.GROUP_OFFSET
        
        showDetailsForProductItem(atIndexPath: IndexPath(row: row, section: section))
    }
    
    @IBAction func discardStoreDetailViewAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func deliveryStartingAction(_ sender: UIButton) {
        Analytics.logEvent("Direct-Delivery-Without-Cart", parameters: nil)
        continueClosingCartViewWithDecision(confirmed: true)
    }
    
    @IBAction func showCartViewAction(_ sender: UIButton) {
        Analytics.logEvent("Show-Cart_Items", parameters: nil)
        showCartDetailsView()
    }
    // MARK: - Product Details view Navigation
    
    func showDetailsForProductItem(atIndexPath indexPath: IndexPath){
        let productItem = store.itemGroups?[indexPath.section].items?[indexPath.row]
        
        if productItem?.optionGroups?.count ?? 0 > 0 {
            // If the Product has options to list
            let rectInTableView = productsTableView.rectForRow(at: indexPath)
            let rectInSuperView = productsTableView.convert(rectInTableView, to: productsTableView.superview)
            showProductDetailsView(product:productItem!, startingFrame: rectInSuperView)
        }
    }
    
    func showProductDetailsView(product:VTItem , startingFrame: CGRect){
        productDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        self.addChildViewController(productDetailsViewController)
        
        productDetailsViewController.delegate = self
        productDetailsViewController.item = product
        productDetailsViewController.store = self.store
        
        
        productDetailsViewController.view.frame = startingFrame
        productDetailsViewController.initialFrame = startingFrame
        self.view.addSubview(productDetailsViewController.view)
        
        productDetailsViewController.didMove(toParentViewController: self)
        
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.blockingView.alpha = 1.0
            },completion:nil)
        
        
    }
    
    func hideDetailsViewController()
    {
        self.productsTableView.reloadData()
        
        productDetailsViewController.removeFromSuperView(animated : true)
        UIView.animate(withDuration: 1, animations: { [unowned self] in
            self.blockingView.alpha = 0.0
            },completion:nil)
    }
    
    //MARK: - CartView Navigation
   
    func showCartDetailsView(){
        
        cartDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController
        self.addChildViewController(cartDetailsViewController!)
        
        cartDetailsViewController?.cartDelegate = self
        
        cartDetailsViewController?.view.frame = self.view.bounds
        cartDetailsViewController?.view.alpha = 0.0
        
        if let childView = cartDetailsViewController?.view{
            self.view.addSubview(childView)
        }
        cartDetailsViewController?.didMove(toParentViewController: self)
        
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.cartDetailsViewController?.view.alpha = 1.0
            },completion:nil)
    }
    
    
    func confirmRequestedCartItems()
    {
        continueClosingCartViewWithDecision(confirmed:true)
    }
    
    func cartItemsUpdated()
    {
        prepareCartView(animated: true)
    }
    
    func continueClosingCartViewWithDecision(confirmed: Bool)
    {
        prepareCartView(animated: false)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: { [unowned self] in
            self.cartDetailsViewController?.view.alpha = 0.0
        }) { [unowned self] _ in
            self.cartDetailsViewController?.view.removeFromSuperview()
            self.cartDetailsViewController?.removeFromParentViewController()
            
            if confirmed {
                
                self.dismiss(animated: true){ [unowned self] in
                    self.storeDelegate?.confirmOrderFromStore()
                }
            }
        }
    }
    
    
}
