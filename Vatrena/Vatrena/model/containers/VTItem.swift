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
    
    var orderDescription : String {
        let optionsDescription = optionGroups?.map { (optionGroup) -> String in
            return optionGroup.orderDescription
        }.joined(separator: "\n")
        return "\(count ?? 0) من \(name ?? "") بمبلغ \(price) ريال لكل وحدة \n \(optionsDescription ?? "")"
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
    
    
    static func parseNode(_ dictionary: [String: Any]) -> VTItem
    {
        let id = (dictionary["id"] as? Int) ?? 0
        let name = dictionary["name"] as? String
        let imageURL = dictionary["imageURL"] as? String
        let offering = dictionary["offering"] as? String
        let price = dictionary["price"] as? Double
        
        let item = VTItem(id: id, name: name, imageURL: imageURL, offering: offering, price: price)
        
        if let optionGroupsDicList = dictionary["optionGroups"] as? [[String: Any]]{
            let optionGroups = optionGroupsDicList.map({ (optionGroupDic) -> VTOptionGroup in
                return VTOptionGroup.parseNode(optionGroupDic)
            })
            
            item.optionGroups = optionGroups
        }
        
        return item
    }
}
