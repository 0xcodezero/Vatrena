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
    
    var itemGroups : [VTItemGroup]?
    
    init(id: Int, name: String?) {
        self.id = id
        self.name = name
        self.itemGroups = []
    }
}
