//
//  MainAppViewController.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 7/29/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit
import FirebaseAnalytics

class MainAppViewController: UIViewController, CartCheckoutDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exploreMarketStoresAction(_ sender: UIButton) {
        // Log Opening Market Action
        Analytics.logEvent("ExploreMarketAction", parameters: nil)
        self.performSegue(withIdentifier: "show-markets-segue", sender: nil)
    }

    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "show-markets-segue", let marketsViewController = segue.destination as? MarketsViewController
        {
            marketsViewController.cartDelegate = self
        }
    }

    func confirmCartCheckout (orderDescription:String, calculatedPricing: Double){
        print("Confirmed Order with Details \n \(orderDescription) , \n with Total amout of: \(calculatedPricing)")
    }
}
