//
//  VTStore.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 7/29/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit

class VTStore: NSObject {
    var id : Int!
    var name : String?
    var offering : String?
    var imageURL : String?
    
    var itemGroups : [VTItemGroup]?
    
    init(id: Int, name: String?, imageURL: String?, offering : String?) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.offering = offering
        self.itemGroups = []
    }
    
    
    static func parseNode(_ dictionary: [String: Any]) -> VTStore
    {
        let id = (dictionary["id"] as? Int) ?? 0
        let name = dictionary["name"] as? String
        let imageURL = dictionary["imageURL"] as? String
        let offering = dictionary["offering"] as? String
        
        let store = VTStore(id: id, name: name, imageURL: imageURL, offering: offering)
        
        if let itemGroupsDicList = dictionary["itemGroups"] as? [[String: Any]]{
            let itemsGroups = itemGroupsDicList.map({ (itemGroupDic) -> VTItemGroup in
                return VTItemGroup.parseNode(itemGroupDic)
            })
            
            store.itemGroups = itemsGroups
        }

        return store
    }
}
