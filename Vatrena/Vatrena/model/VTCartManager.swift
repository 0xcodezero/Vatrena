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
        
        let albeek = VTStore(id: 1, name: "البيك", imageURL: "albeek",offering: "أشهي مأكولات البروست والمسحب مع أطعم الساندويتشات")
        let altazej = VTStore(id: 2, name: "الطازج", imageURL: "altazej", offering: "الفروج وما أدراك ما الفروج")
        let redan = VTStore(id: 1, name: "مطاعم ريدان", imageURL: "redan", offering: "")
        let bety = VTStore(id: 2, name: "كودو", imageURL: "kudu", offering: "")
        
        
        
        let sandwatshat = VTItemGroup(id: 1, name: "ساندويتشات")
        let wagabat = VTItemGroup(id: 2, name: "وجبات")
        let mashroubat = VTItemGroup(id: 3, name: "مشروبات")
        let salatat = VTItemGroup(id: 4, name: "سلطات")
        
        albeek.itemGroups?.append(sandwatshat)
        albeek.itemGroups?.append(wagabat)
        albeek.itemGroups?.append(mashroubat)
        albeek.itemGroups?.append(salatat)
        
        let alBig = VTItem(id: 1, name: "البيج", price: 10.0)
        let felehDagag = VTItem(id: 2, name: "فيليه دجاج", price: 4.0)
        let gambary = VTItem(id: 3, name: "جمبري", price: 8.0)
        
        sandwatshat.items?.append(alBig)
        sandwatshat.items?.append(felehDagag)
        sandwatshat.items?.append(gambary)
        
        
        let borst = VTItem(id: 1, name: "بروست", price: 10.0)
        let mesa7ab = VTItem(id: 1, name: "مسحب دجاج", price: 4.0)
        let mesa7abSamak = VTItem(id: 1, name: "مسحب سمك", price: 4.0)
        let gambaryJamboo = VTItem(id: 1, name: " جامبو جمبري", price: 8.0)
        
        wagabat.items?.append(borst)
        wagabat.items?.append(mesa7ab)
        wagabat.items?.append(mesa7abSamak)
        wagabat.items?.append(gambaryJamboo)
        
        
        let drink1 = VTItem(id: 1, name: "مياة", price: 1.0)
        let drink2 = VTItem(id: 1, name: "عصير", price: 1.0)
        let drink3 = VTItem(id: 2, name: "بيبسي", price: 2.0)
        mashroubat.items?.append(drink1)
        mashroubat.items?.append(drink2)
        mashroubat.items?.append(drink3)
        
        
        let salad1 = VTItem(id: 1, name: "سلطة خضراء", price: 3.0)
        let salad2 = VTItem(id: 2, name: "سلطة ملفوف", price: 3.0)
        salatat.items?.append(salad1)
        salatat.items?.append(salad2)
        
        mataem.stores?.append(albeek)
        mataem.stores?.append(altazej)
        mataem.stores?.append(redan)
        mataem.stores?.append(bety)
        
        
        let malls = VTMarket(id: 1, name: "Malls")
        
        let mall1 = VTStore(id: 1, name: "mall1", imageURL: "albeek", offering: "")
        let mall2 = VTStore(id: 2, name: "mall2", imageURL: "albeek", offering: "")
        let mall3 = VTStore(id: 3, name: "mall3", imageURL: "albeek", offering: "")
        let mall4 = VTStore(id: 4, name: "mall4", imageURL: "albeek", offering: "")
        
        
        malls.stores?.append(mall1)
        malls.stores?.append(mall2)
        malls.stores?.append(mall3)
        malls.stores?.append(mall4)
        
        
        let saydalyat = VTMarket(id: 2, name: "صيدليات")
        
        let alnahdi = VTStore(id: 1, name: "النهدي", imageURL: "albeek", offering: "")
        let aldawaa = VTStore(id: 2, name: "الدواء", imageURL: "albeek", offering: "")
        
        saydalyat.stores?.append(alnahdi)
        saydalyat.stores?.append(aldawaa)
        
        markets?.append(mataem)
        markets?.append(saydalyat)
        markets?.append(malls)
        
    }
}
