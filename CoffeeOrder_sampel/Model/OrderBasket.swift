//
//  OrderBasket.swift
//  CoffeeOrder_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import Foundation
import Firebase

class OrderBasket: Identifiable {
    
    var id = ""
    var ownerId = ""
    var items: [Drink] = []
    
    var total: Double {
        if items.count > 0 {
            return items.reduce(0){ $0 + $1.price}
        } else {
            return 0.0
        }
    }
    
    func add(_ item: Drink) {
        items.append(item)
    }
    
    func remove(_ item: Drink) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    
    func emptyBasket() {
        self.items = []
        
    }
    
    func saveBasketToFirestore() {
        FirebaseReference(.Basket).document(self.id).setData(<#T##documentData: [String : Any]##[String : Any]#>)
    }
    
}

func basketDictionartFrom(_ basket: OrderBasket) -> [String : Any] {
    
}
