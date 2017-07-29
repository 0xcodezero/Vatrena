//
//  MarketsViewController.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 7/29/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit



class MarketsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var storesTableView: UITableView!
    let cellReuseIdentifier = "store-cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func discardMarketViewAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
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
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80))
        view.backgroundColor = UIColor.red
        
        let headerLable = UILabel(frame: CGRect(x: 10  , y: 10, width: self.view.frame.size.width - 20 , height: 60))
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
