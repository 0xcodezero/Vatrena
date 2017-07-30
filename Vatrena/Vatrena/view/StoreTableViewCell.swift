//
//  StoreTableViewCell.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 7/29/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit

class StoreTableViewCell: UITableViewCell {

    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var storeDescriptionLabel: UILabel!
    @IBOutlet weak var storeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
