//
//  VTItem.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 7/29/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit

class VTItem: NSObject {
    
    var id : Int!
    var name : String?
    var offering : String?
    var imageURL : String?
    var count : Int!
    private var _price : Double?
    var optionGroups : [VTOptionGroup]?
    
    
    var price : Double{
        var calcuatedPrice = _price ?? 0.0
        
        if let groups = optionGroups {
            for optionGroup in groups {
                
                if let options = optionGroup.options {
                    for option in options {
                        calcuatedPrice += (option.selected == true) ? (option.deltaPrice) : 0.0
                    }
                }
                
                
            }
        }
        
        return calcuatedPrice
    }
    
    init(id: Int, name: String?,imageURL: String?, offering: String?, price: Double?) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.offering = offering
        self._price = price ?? 0.0
        self.count = 0
        self.optionGroups = []
    }
}
