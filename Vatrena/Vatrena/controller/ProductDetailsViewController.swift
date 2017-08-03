//
//  ProductDetailsViewController.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 8/2/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit

protocol ProductDetailsDelegate {
    
}


class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var defaultpriceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var removeItemButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var removeItemContainerView: UIView!
    @IBOutlet weak var buttonsContainerView: UIView!
    
    var item : VTItem!
    var store: VTStore!
    
    var initialFrame : CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews(animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 1, animations: { [unowned self] in
            self.view.frame = CGRect(x: 0, y: 80, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 160)
            self.productNameLabel.alpha = 1.0
            self.buttonsContainerView.alpha = 1.0
        }) { [unowned self] _ in
            
            
            UIView.animate(withDuration: 1, delay: 0.05, options: [], animations: {
                self.defaultpriceLabel.alpha = 1.0
                self.descriptionLabel.alpha = 1.0
            })
        }
    }
    
    func prepareViews(animated: Bool){
        productNameLabel.text = item.name
        defaultpriceLabel.text = "\(item.price ?? 0.0) SAR"
        descriptionLabel.text = item.offering
        productImageView.image = UIImage(named: item.imageURL ?? "product-placeholder")
        
        
        UIView.transition(with: countLabel,
                          duration: animated ? 0.1 : 0.0,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.countLabel.text = "x\(self?.item.count ?? 0)"
            }, completion: nil)
        
        removeItemContainerView.isHidden = (item.count ?? 0 ) == 0
    }
    
    
    func removeFromSuperView(animated : Bool){
        
        
        
        self.defaultpriceLabel.alpha = 0.0
        self.descriptionLabel.alpha = 0.0
        self.productNameLabel.alpha = 0.0
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: { [unowned self] in
            self.view.frame = self.initialFrame
            self.buttonsContainerView.alpha = 0.0
            self.view.alpha = 0.0
        }) { [unowned self] _ in
            
            
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
            
        }
        
        
        
    }

}
