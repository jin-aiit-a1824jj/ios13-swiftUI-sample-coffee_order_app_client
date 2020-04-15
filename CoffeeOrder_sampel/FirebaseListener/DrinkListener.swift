//
//  DrinkListener.swift
//  CoffeeOrder_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import Foundation
import Firebase

class DrinkListener: ObservableObject {
    
    @Published var drinks: [Drink] = []
    
    init() {
        downloadDrinks()
    }
    
    func downloadDrinks() {
        FirebaseReference(.Menu).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            if !snapshot.isEmpty {
                self.drinks = DrinkListener.drinkFromDictionary(snapshot)
            }
        }
    }
    
    static func drinkFromDictionary(_ snapshot: QuerySnapshot) -> [Drink] {
        var allDrinks: [Drink] = []
        
        for snapshot in snapshot.documents {
            let drinkData = snapshot.data()
            let drinkItem = Drink(id: drinkData[kID] as? String ?? UUID().uuidString,
                                            name: drinkData[kNAME] as? String ?? "unknown",
                                            imageName: drinkData[kIMAGENAME] as? String ?? "unknown",
                                            category: Category(rawValue: drinkData[kCATEGORY] as? String ?? "cold") ?? .cold,
                                            description:drinkData[kDESCRIPTION] as? String ?? "Description is missing" ,
                                            price:  drinkData[kPRICE] as? Double ?? 0.0)
            allDrinks.append(drinkItem)
        }
        
        return allDrinks
    }
}
