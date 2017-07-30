//
//  VTCartManager.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 7/29/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit

final class VTCartManager: NSObject {
    
    static let sharedInstance = VTCartManager()
    
    var markets : [VTMarket]?
    var cartItems : [VTItem]?

    
    private override init() {
        cartItems = []
        markets = []
        
        let mataem = VTMarket(id: 1, name: "مطاعم")
        
        let albeek = VTStore(id: 1, name: "البيك",offering: "أشهي مأكولات البروست والمسحب مع أطعم الساندويتشات")
        let altazej = VTStore(id: 2, name: "الطازج", offering: "الفروج وما أدراك ما الفروج")
        let redan = VTStore(id: 1, name: "redan", offering: "")
        let bety = VTStore(id: 2, name: "bety", offering: "")
        
        
        mataem.stores?.append(albeek)
        mataem.stores?.append(altazej)
        mataem.stores?.append(redan)
        mataem.stores?.append(bety)
        
        
        let malls = VTMarket(id: 1, name: "Malls")
        
        let mall1 = VTStore(id: 1, name: "mall1", offering: "")
        let mall2 = VTStore(id: 2, name: "mall2", offering: "")
        let mall3 = VTStore(id: 1, name: "mall3", offering: "")
        let mall4 = VTStore(id: 2, name: "mall4", offering: "")
        
        
        malls.stores?.append(mall1)
        malls.stores?.append(mall2)
        malls.stores?.append(mall3)
        malls.stores?.append(mall4)
        
        
        let saydalyat = VTMarket(id: 2, name: "صيدليات")
        
        let alnahdi = VTStore(id: 1, name: "النهدي", offering: "")
        let aldawaa = VTStore(id: 2, name: "الدواء", offering: "")
        
        saydalyat.stores?.append(alnahdi)
        saydalyat.stores?.append(aldawaa)
        
        markets?.append(mataem)
        markets?.append(saydalyat)
        markets?.append(malls)
        
    }
}
