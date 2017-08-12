//
//  ProductTableViewCell.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 7/30/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var defaultpriceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var removeItemButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var removeItemContainerView: UIView!
    @IBOutlet weak var showDetailsButton: UIButton!
    
    var item : VTItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setProductItem(_ item: VTItem){
        self.item = item
        prepareViews(animated: false)
    }
    
    @IBAction func addItemToCartAction(_ sender: UIButton) {
        item.count = (item.count ?? 0 ) + 1
        prepareViews(animated: true)
    }
    

    @IBAction func removeItemFromCartAction(_ sender: UIButton) {
        item.count = (item.count ?? 0 ) - 1
        prepareViews(animated: true)
    }
    
    func prepareViews(animated: Bool){
        productNameLabel.text = item.name
        defaultpriceLabel.text = "\(item.price) ريال"
        descriptionLabel.text = item.offering
        productImageView.image = UIImage(named: "product-placeholder")
        
        productImageView.loadingImageUsingCache(withURLString: item.imageURL ?? "")
        
        UIView.transition(with: countLabel,
                          duration: animated ? 0.1 : 0.0,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.countLabel.text = "x\(self?.item.count ?? 0)"
            }, completion: nil)
        
        removeItemContainerView.isHidden = (item.count ?? 0 ) == 0
        showDetailsButton.isHidden = (item.optionGroups?.count ?? 0) == 0
    }
    
}
