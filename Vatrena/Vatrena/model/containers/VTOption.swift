//
//  VTOption.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 7/29/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit

class VTOption: NSObject {

    var id : Int!
    var name : String?
    var selected : Bool!
    var deltaPrice : Double!
    
    
    init(id: Int, name: String?, selected: Bool?, deltaPrice: Double?) {
        self.id = id
        self.name = name
        self.selected = selected ?? false
        self.deltaPrice = deltaPrice ?? 0.0
    }
    
    
    
    static func parseNode(_ dictionary: [String: Any]) -> VTOption
    {
        let id = (dictionary["id"] as? Int) ?? 0
        let name = dictionary["name"] as? String
        let selected = (dictionary["selected"] as? Bool) ?? false
        let deltaPrice = (dictionary["delta"] as? Double) ?? 0.0
        
        let option = VTOption(id: id, name: name, selected: selected, deltaPrice: deltaPrice)
        
        return option
    }
    
}
