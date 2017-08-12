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
    
    var orderDescription : String {
        if let options = options {
            let selectedOptions = options.filter({$0.selected})
            if selectedOptions.count > 0 {
                return "\(name ?? ""):\n \(selectedOptions.map({ return "\($0.name ?? "")"}).joined(separator: ", "))"
            }
        }
        return ""
    }
    
    init(id: Int, name: String?, selectionType: SelectionType?){
        self.id = id
        self.name = name
        
        self.selectionType = selectionType ?? .single
        self.options = []
    }
    
    
    
    
    static func parseNode(_ dictionary: [String: Any]) -> VTOptionGroup
    {
        let id = (dictionary["id"] as? Int) ?? 0
        let name = dictionary["name"] as? String
        
        var finalSelectionType = SelectionType.single
        if let selectionType = dictionary["type"] as? String {
            finalSelectionType = (selectionType == "multiple") ? .multiple : .single
        }
        
        let optionGroup = VTOptionGroup(id: id, name: name, selectionType:finalSelectionType)
        
        if let optionsDicList = dictionary["options"] as? [[String: Any]]{
            let options = optionsDicList.map({ (optionDic) -> VTOption in
                return VTOption.parseNode(optionDic)
            })
            
            optionGroup.options = options
        }
        
        return optionGroup
    }
}
