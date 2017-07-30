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
}
