//
//  MarketsViewController.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 7/29/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit
import PKHUD

protocol CartCheckoutDelegate{
    func cartCheckoutConfirmed (storeName: String, orderDescription:String, calculatedPricing: Double)
}

class MarketsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, CartActionsDelegate {

    let cellReuseIdentifier = "store-cell"
    let headerHeight = CGFloat(40.0)
    var selectedStore : VTStore?
    
    @IBOutlet weak var storesTableView: UITableView!
    @IBOutlet weak var segmentContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberOfCartItemsLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton!

    var cartDelegate : CartCheckoutDelegate?
    
    var cartDetailsViewController : CartViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = Constants.STORES_VIEW_TITLE
        storesTableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0)
        self.segmentContainerView.alpha = 0.0
        
        HUD.show(.labeledProgress(title: nil, subtitle:"جاري تحميل البيانات.." ))
        
        
        VTCartManager.sharedInstance.startLoadingVatrenaData {[unowned self] (markets) in
            self.setupMarektsSegmentView()
            self.storesTableView.reloadData()
            PKHUD.sharedHUD.hide(afterDelay: 0.3)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func discardMarketViewAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareCartViews(animated: false)
    }
    //MARK: - Views Customization
    func setupMarektsSegmentView () {
        
        if ((VTCartManager.sharedInstance.markets?.count) ?? 0 < Constants.MINIMUM_NUNMBER_OF_SECTIONS_TO_SHOW_SEGMENT ) { // Two Items are sufficient for showing the segment view
            storesTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            return
        }
        
        let segment = NLSegmentControl(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        segment.segments = VTCartManager.sharedInstance.markets?.map({ return $0.name ?? ""}) ?? []
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
            if ((VTCartManager.sharedInstance.markets?[index].stores?.count) ?? 0 > 0 ){
                self.storesTableView.scrollToRow(at: IndexPath(row: 0, section: index) , at: .top, animated: true)
            }
        }
        self.segmentContainerView.alpha = 1.0
        self.segmentContainerView.addSubview(segment)
        segment.reloadSegments()
    }
    
    func prepareCartViews(animated: Bool){
        numberOfCartItemsLabel.isHidden = (VTCartManager.sharedInstance.cartItems?.count ?? 0 ) == 0
        numberOfCartItemsLabel.text = "\(VTCartManager.sharedInstance.calclateTotalNumberOfCartItems())"
        cartButton.isHidden = (VTCartManager.sharedInstance.cartItems?.count ?? 0 ) == 0
    }
    
    
    //MARK: - TableView DataSource & Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = storesTableView.dequeueReusableCell(withIdentifier:cellReuseIdentifier ) as! StoreTableViewCell
        
        let store = VTCartManager.sharedInstance.markets?[indexPath.section].stores?[indexPath.row]
        // set the text from the data model
        cell.selectionStyle = .none
        cell.storeNameLabel.text = store?.name
        cell.storeDescriptionLabel.text = store?.offering
        cell.storeImageView.image = UIImage(named: "store-placeholder")
        
        cell.storeImageView.loadingImageUsingCache(withURLString: store?.imageURL ?? "")
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return VTCartManager.sharedInstance.markets?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VTCartManager.sharedInstance.markets?[section].stores?.count ?? 0
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedStore = VTCartManager.sharedInstance.markets?[indexPath.section].stores?[indexPath.row]
        if let cartStore = VTCartManager.sharedInstance.selectedStore , cartStore != selectedStore{
            
            
            let alretView = UIAlertController(title: "تنبيه", message:("لديك طلب مفتوح من \(cartStore.name ?? "")") , preferredStyle: UIAlertControllerStyle.alert)
            
            let openCartAction = UIAlertAction(title: "افتح قائمة المشتريات", style:.default) { [unowned self] (_) in
                self.showCartDetailsView()
            }
            
            let continueAction = UIAlertAction(title: "اكمل طلبك السابق", style:.default) { [unowned self] (_) in
                self.selectedStore = cartStore
                self.performSegue(withIdentifier: "show-store-segue", sender: nil)
            }
            
            let discardAction = UIAlertAction(title: "تجاهل الطلب السابق", style:.destructive) { [unowned self](_) in
                VTCartManager.sharedInstance.resetCartManager()
                self.performSegue(withIdentifier: "show-store-segue", sender: nil)
            }
            
            alretView.addAction(openCartAction)
            alretView.addAction(continueAction)
            alretView.addAction(discardAction)
            
            self.present(alretView, animated: true, completion: nil)
            
        }else{
            self.performSegue(withIdentifier: "show-store-segue", sender: nil)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: headerHeight))
        view.backgroundColor = UIColor.clear
        
        let headerLable = UILabel(frame: CGRect(x: 10  , y: 10, width: self.view.frame.size.width - 20 , height: headerHeight - 20))
        headerLable.text = VTCartManager.sharedInstance.markets?[section].name
        headerLable.textAlignment = .right
        headerLable.font = UIFont.systemFont(ofSize: 24)
        headerLable.textColor = UIColor.white
        view.addSubview(headerLable)
        
        return view
    }

    
    // MARK: - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     
         if segue.identifier == "show-store-segue", let storeViewController = segue.destination as? StoreViewController
         {
            storeViewController.store = selectedStore
         }
     }

    @IBAction func showCartViewAction(_ sender: UIButton) {
        showCartDetailsView()
    }
    
    
    func showCartDetailsView(){
        
        cartDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        self.addChildViewController(cartDetailsViewController)
        
        cartDetailsViewController.cartDelegate = self
        
        cartDetailsViewController.view.frame = self.view.bounds
        cartDetailsViewController.view.alpha = 0.0
        
        self.view.addSubview(cartDetailsViewController.view)
        cartDetailsViewController.didMove(toParentViewController: self)
        
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.cartDetailsViewController.view.alpha = 1.0
        },completion:nil)
    }
    
    
    func confirmRequestedCartItems()
    {
        continueClosingCartViewWithDecision(confirmed:true)
    }
    
    func cartItemsUpdated()
    {
        prepareCartViews(animated: true)
    }
    
    func continueClosingCartViewWithDecision(confirmed: Bool)
    {
        prepareCartViews(animated: false)
        
        UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseOut], animations: { [unowned self] in
            self.cartDetailsViewController.view.alpha = 0.0
        }) { [unowned self] _ in
            self.cartDetailsViewController.view.removeFromSuperview()
            self.cartDetailsViewController.removeFromParentViewController()
            
            if confirmed {
                
                self.dismiss(animated: true){ [unowned self] in
                    let cartManager = VTCartManager.sharedInstance
                    self.cartDelegate?.cartCheckoutConfirmed(storeName: cartManager.selectedStore?.name ?? "", orderDescription: cartManager.generateOrderDetails(), calculatedPricing: cartManager.calclateTotalOrderCost())
                    
                    cartManager.resetCartManager()
                }
            }
        }
    }

    
}
