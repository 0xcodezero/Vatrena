//
//  MarketsViewController.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 7/29/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit

protocol CartCheckoutDelegate{
    func confirmCartCheckout (orderDescription:String, calculatedPricing: Double)
}

class MarketsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    let cellReuseIdentifier = "store-cell"
    let headerHeight = CGFloat(40.0)
    
    @IBOutlet weak var storesTableView: UITableView!
    @IBOutlet weak var segmentContainerView: UIView!

    var cartDelegate : CartCheckoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMarektsSegmentView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func discardMarketViewAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Views Customization
    func setupMarektsSegmentView () {
        let segment = NLSegmentControl(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        segment.segments = VTCartManager.sharedInstance.markets?.map({ return $0.name ?? ""}) ?? []
        segment.segmentWidthStyle = .dynamic
        segment.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        segment.selectionIndicatorHeight = 4.0
        segment.selectionIndicatorColor = .red
        segment.selectionIndicatorPosition = .bottom
        segment.enableVerticalDivider = true
        segment.verticalDividerWidth = 1
        segment.verticalDividerInset = 12
        
        segment.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0), NSForegroundColorAttributeName: UIColor.black]
        segment.selectedTitleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0), NSForegroundColorAttributeName: UIColor.red]
        
        segment.indexChangedHandler = { (index) in
            self.storesTableView.scrollToRow(at: IndexPath(row: 0, section: index) , at: .top, animated: true)
        }
        self.segmentContainerView.addSubview(segment)
        segment.reloadSegments()
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
//            segment.setSelectedSegmentIndex(5, animated: false)
//        }
    }
    
    
    //MARK: - TableView DataSource & Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = storesTableView.dequeueReusableCell(withIdentifier:cellReuseIdentifier ) as! StoreTableViewCell
        
        // set the text from the data model
        cell.textLabel?.text = VTCartManager.sharedInstance.markets?[indexPath.section].stores?[indexPath.row].name
        
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
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: headerHeight))
        view.backgroundColor = UIColor.red
        
        let headerLable = UILabel(frame: CGRect(x: 10  , y: 10, width: self.view.frame.size.width - 20 , height: headerHeight - 20))
        headerLable.text = VTCartManager.sharedInstance.markets?[section].name
        headerLable.textAlignment = .right
        headerLable.font = UIFont.systemFont(ofSize: 24)
        headerLable.textColor = UIColor.white
        view.addSubview(headerLable)
        
        return view
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
