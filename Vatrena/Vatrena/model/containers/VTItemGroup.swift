//
//  VTItemGroup.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 7/29/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit

class VTItemGroup: NSObject {
    
    var id : Int!
    var name : String?
    var items : [VTItem]?
    
    
    init(id: Int, name: String?) {
        self.id = id
        self.name = name
        self.items = []
    }
    
    
    static func parseNode(_ dictionary: [String: Any]) -> VTItemGroup
    {
        let id = (dictionary["id"] as? Int) ?? 0
        let name = dictionary["name"] as? String
        
        let itemGroup = VTItemGroup(id: id, name: name)
        
        if let itemsDicList = dictionary["items"] as? [[String: Any]]{
            let items = itemsDicList.map({ (itemDic) -> VTItem in
                return VTItem.parseNode(itemDic)
            })
            
            itemGroup.items = items
        }
        
        return itemGroup
    }
}
