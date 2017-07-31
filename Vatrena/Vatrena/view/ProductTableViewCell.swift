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
        prepareViews()
    }
    
    @IBAction func addItemToCartAction(_ sender: UIButton) {
        item.count = (item.count ?? 0 ) + 1
        prepareViews()
    }
    

    @IBAction func removeItemFromCartAction(_ sender: UIButton) {
        item.count = (item.count ?? 0 ) - 1
        prepareViews()
    }
    
    func prepareViews(){
        productNameLabel.text = item.name
        defaultpriceLabel.text = "\(item.price ?? 0.0) SAR"
        descriptionLabel.text = item.offering
        productImageView.image = UIImage(named: item.imageURL ?? "product-placeholder")
        
        countLabel.text = "x\(item.count ?? 0)"
        removeItemContainerView.isHidden = (item.count ?? 0 ) == 0
    }
    
}
