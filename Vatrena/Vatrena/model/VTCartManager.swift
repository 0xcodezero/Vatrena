//
//  VTCartManager.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 7/29/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

final class VTCartManager: NSObject {
    
    static let sharedInstance = VTCartManager()
    
    var markets : [VTMarket]?
    var cartItems : [VTItem]?
    var selectedStore : VTStore?
    var databaseRef : DatabaseReference?
    
    private override init() {
        self.databaseRef = Database.database().reference()
    }
    
    func updateItemInsideCart(store: VTStore?, item: VTItem){
        if (item.count ?? 0) == 0 {
            if let index = VTCartManager.sharedInstance.cartItems?.index(of: item) {
                VTCartManager.sharedInstance.cartItems?.remove(at: index)
            }
            
            if cartItems?.count ?? 0 == 0 {
                selectedStore = nil
            }
            
        }else if !(VTCartManager.sharedInstance.cartItems?.contains(item) ?? false){
                VTCartManager.sharedInstance.cartItems?.append(item)
                selectedStore = store
        }
    }
    
    
    func calclateTotalNumberOfCartItems() -> Int
    {
        return cartItems?.reduce(0){ $0 + $1.count} ?? 0
    }
    
    func generateOrderDetails() -> String {
        
        return VTCartManager.sharedInstance.cartItems?.map({ (cartItem) -> String in
            return cartItem.orderDescription
        }).joined(separator: "\n") ?? ""
    }
    
    func calclateTotalOrderCost() -> Double
    {
        let cost = cartItems?.reduce(0){ $0 + (Double($1.count!) * $1.price) } ?? 0
        return cost
    }
    
    func resetCartManager()
    {
        if let items = cartItems{
            for item in items{
                item.count = 0
            }
            
            cartItems?.removeAll()
            selectedStore = nil
        }
    }
    
    
    func startLoadingVatrenaData(completion: @escaping( _ result: [VTMarket]) -> Void) {
        
        
        if let markets = self.markets {
            completion(markets)
        }else{
            
            self.databaseRef?.child("markets").queryOrdered(byChild: "id").observeSingleEvent(of:.value, with: {[unowned self](snapshot) in
                
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                    
                    self.cartItems = []
                    self.markets = []
                    
                    for snap in snapshot {
                        if let postDict = snap.value as? [String : Any] {
                            self.markets?.append(VTMarket.parseNode(postDict))
                        }
                    }
                    
                    completion(self.markets!)
                }
            })
        
        }
        
        
    }
    
    
}
