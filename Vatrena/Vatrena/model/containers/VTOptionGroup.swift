//
//  VTOptionGroup.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 7/29/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit

enum SelectionType {
    case single
    case multiple
}

class VTOptionGroup: NSObject {
    
    var id : Int!
    var name : String?
    var selectionType : SelectionType
    
    var options : [VTOption]?
    
    init(id: Int, name: String?, selectionType: SelectionType?){
        self.id = id
        self.name = name
        
        self.selectionType = selectionType ?? .single
        self.options = []
    }
}
