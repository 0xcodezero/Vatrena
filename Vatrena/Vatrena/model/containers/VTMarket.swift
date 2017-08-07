//
//  VTMarket.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 7/29/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit

class VTMarket: NSObject {
    
    var id : Int!
    var name : String?
    var stores : [VTStore]?
    
    
    init(id: Int, name: String?) {
        self.id = id
        self.name = name
        stores = []
    }
    
    
    static func parseNode(_ dictionary: [String: Any]) -> VTMarket{
        let id = (dictionary["id"] as? Int) ?? 0
        let name = dictionary["name"] as? String
        
        let market = VTMarket(id: id, name: name)
        
        if let storesDicList = dictionary["stores"] as? [[String: Any]]{
            let stores = storesDicList.map({ (storeDic) -> VTStore in
                return VTStore.parseNode(storeDic)
            })
            
            market.stores = stores
        }
        
        
        return market
    }
}
