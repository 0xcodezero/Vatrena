//
//  OptionCollectionViewCell.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 8/5/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit

class OptionCollectionViewCell: UICollectionViewCell {
    
    private var _option : VTOption!
    @IBOutlet weak var optionButton: UIButton!
    
    var option:VTOption {
        return _option
    }
    
    
    func setOptionItem(_ option: VTOption) {
        self._option = option
        optionButton.setTitle(option.name, for: .normal)
        optionButton.setTitle(option.name, for: .selected)
        optionButton.isSelected = option.selected
    }
    
}
