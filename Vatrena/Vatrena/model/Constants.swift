//
//  Constants.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 8/5/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    static let GROUP_OFFSET = 1000
    
    //MARK: - STORE ViewController Constants
    static let storeHeaderHeight = CGFloat(40.0)
    
    
    
    //MARK: - Static Functions
    static func displayAlert(_ view:UIViewController ,title : String , Message : String ) {
        
        let ErrorMessage = UIAlertController(title: title, message: Message, preferredStyle: UIAlertControllerStyle.alert)
        let okButton = UIAlertAction(title: NSLocalizedString("alert-ok", comment: ""), style: UIAlertActionStyle.default, handler: nil)
        ErrorMessage.addAction(okButton)
        view.present(ErrorMessage, animated: true, completion: nil)
    }
    
    
    
    static func displayAlert(_ view:UIViewController ,title : String , Message : String ,Handler:@escaping (UIAlertAction)->Void) {
        
        let ErrorMessage = UIAlertController(title: title, message: Message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okButton = UIAlertAction(title: NSLocalizedString("alert-ok", comment: ""), style: UIAlertActionStyle.default, handler: Handler)
        let cancelButton = UIAlertAction(title: NSLocalizedString("alert-cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil)
        ErrorMessage.addAction(okButton)
        ErrorMessage.addAction(cancelButton)
        
        view.present(ErrorMessage, animated: true, completion: nil)
    }
    static func displayAlertWithOkButton(_ view:UIViewController ,title : String , Message : String ,Handler:@escaping (UIAlertAction)->Void) {
        
        let errorMessageAlertController = UIAlertController(title: title, message: Message, preferredStyle: UIAlertControllerStyle.alert)
        let okButton = UIAlertAction(title: NSLocalizedString("alert-ok", comment: ""), style: UIAlertActionStyle.default, handler: Handler)
        errorMessageAlertController.addAction(okButton)
        
        view.present(errorMessageAlertController, animated: true, completion: nil)
    }
    
    
    static func getQuantitiyTitle(number: Int, singular: String, pair: String, few: String, lot: String ) -> String {
        switch number {
        case 0:
            return NSLocalizedString("zero", comment: "")
        case 1:
            return singular
        case 2:
            return pair
        case 3,4,5,6,7,8,9,10 :
            return "\(number) \(few)"
        default:
            return "\(number) \(lot)"
        }
        
    }

    
}
