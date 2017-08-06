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
    var selectedStore : VTStore?
    
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
        
        albeek.itemGroups?.append(wagabat)
        albeek.itemGroups?.append(sandwatshat)
        albeek.itemGroups?.append(mashroubat)
        albeek.itemGroups?.append(salatat)
        
        let alBig = VTItem(id: 1, name: "البيج",imageURL: "big-beek", offering: "ساندويتش", price: 10.0)
        let gambary = VTItem(id: 2, name: "جمبري",imageURL: "sandwitch-gambary", offering: "جمبري جامبو مقرمش مع صلصة الكوكتيل", price: 8.0)
        let felehDagag = VTItem(id: 3, name: "برجر فيليه دجاج",imageURL: "burger-feleh", offering: "ساندويتش", price: 3.0)
        
        
        sandwatshat.items?.append(alBig)
        sandwatshat.items?.append(gambary)
        sandwatshat.items?.append(felehDagag)
        
        
        let borst = VTItem(id: 1, name: "بروست دجاج",imageURL: "broast", offering: "4 قطع دجاج مقدمة مع البطاطا المقلية المهلبية  المقرمشة و حبات الخبز", price: 12.0)
        let mesa7ab = VTItem(id: 1, name: "مسحب دجاج",imageURL: "mesa7ab", offering: "7 قطع دجاج مسحب مقدم مع بطاطا", price: 12.0)
        let mesa7abSamak = VTItem(id: 1, name: "مسحب سمك",imageURL: "samak-mesa7ab", offering: "6 قطع من فيليه السمك تقدم مع البطاطا", price: 4.0)
        let gambaryJamboo = VTItem(id: 1, name: "جامبو جمبري",imageURL: "jambo-gambary", offering: "8 قطع جمبري جامبو تقدم مع البطاطا", price: 8.0)
        
        wagabat.items?.append(borst)
        wagabat.items?.append(mesa7ab)
        wagabat.items?.append(mesa7abSamak)
        wagabat.items?.append(gambaryJamboo)
        
        
        
        let broastSizeOptionGroup = VTOptionGroup(id: 1, name: "الحجم", selectionType: .single)
        let broast4Pieces = VTOption(id: 1, name: "٤ قطع", selected:true, deltaPrice: 0)
        let broast8Pieces = VTOption(id: 2, name: "٨ قطع", selected:false, deltaPrice: 11.0)
        broastSizeOptionGroup.options?.append(broast4Pieces)
        broastSizeOptionGroup.options?.append(broast8Pieces)
        
        
        let broastHotOptionGroup = VTOptionGroup(id: 1, name: "توابل", selectionType: .single)
        let broastRegular = VTOption(id: 1, name: "عادي", selected:true, deltaPrice: 0)
        let broastHot = VTOption(id: 2, name:  "حار", selected:false, deltaPrice: 0.0)
        broastHotOptionGroup.options?.append(broastRegular)
        broastHotOptionGroup.options?.append(broastHot)
        
        
        let broastExtrasOptionGroup = VTOptionGroup(id: 1, name: "الزيادات", selectionType: .multiple)
        let broastbread = VTOption(id: 1, name: "خبز", selected:false, deltaPrice: 1)
        let broastTomayah = VTOption(id: 2, name:  "ثومية", selected:false, deltaPrice: 0.5)
        let broastKatshab = VTOption(id: 3, name:  "كاتشب", selected:false, deltaPrice: 0.25)
        broastExtrasOptionGroup.options?.append(broastbread)
        broastExtrasOptionGroup.options?.append(broastTomayah)
        broastExtrasOptionGroup.options?.append(broastKatshab)
        
        borst.optionGroups?.append(broastSizeOptionGroup)
        borst.optionGroups?.append(broastHotOptionGroup)
        borst.optionGroups?.append(broastExtrasOptionGroup)
        
        let drink1 = VTItem(id: 1, name: "مياة",imageURL: "albeek", offering: "قطعتان مسحب", price: 1.0)
        let drink2 = VTItem(id: 1, name: "عصير",imageURL: "albeek", offering: "قطعتان مسحب", price: 1.0)
        let drink3 = VTItem(id: 2, name: "بيبسي",imageURL: "albeek", offering: "قطعتان مسحب", price: 2.0)
        mashroubat.items?.append(drink1)
        mashroubat.items?.append(drink2)
        mashroubat.items?.append(drink3)
        
        
        let salad1 = VTItem(id: 1, name: "سلطة خضراء",imageURL: "albeek", offering: "قطعتان مسحب", price: 3.0)
        let salad2 = VTItem(id: 2, name: "سلطة ملفوف",imageURL: "albeek", offering: "قطعتان مسحب", price: 3.0)
        salatat.items?.append(salad1)
        salatat.items?.append(salad2)
        
        mataem.stores?.append(albeek)
        mataem.stores?.append(altazej)
        mataem.stores?.append(redan)
        mataem.stores?.append(bety)
        
        
        let malls = VTMarket(id: 1, name: "بقالات")
        
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
}
