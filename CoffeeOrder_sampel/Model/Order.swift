//
//  Order.swift
//  CoffeeOrder_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import Foundation

class Order: Identifiable {
    
    var id = ""
    var customerId = ""
    var orderItems: [Drink] = []
    var amount = 0.0
    
    var customerName = ""
    var isCompleted = false
    
    func saveOrderToFirestore() {
        FirebaseReference(.Order).document(self.id).setData(orderDictionaryFrom(self)) { error in
            if error != nil {
                print("error saving order to firestore: ", error!.localizedDescription)
            }
        }
    }
    
}

func orderDictionaryFrom(_ order: Order) -> [String : Any] {
    var allDrinkIds: [String] = []
    
    for drink in order.orderItems {
        allDrinkIds.append(drink.id)
    }
    
    return NSDictionary(objects:[order.id,
                                   order.customerId,
                                   allDrinkIds,
                                   order.amount,
                                   order.customerName,
                                   order.isCompleted],
                        forKeys:[ kID as NSCopying,
                                       kCUSTOMERID as NSCopying,
                                       kDRINKIDS as NSCopying,
                                       kAMOUNT as NSCopying,
                                       kCUSTOMERNAME as NSCopying,
                                       kISCOMPLETED as NSCopying
    ]) as! [String : Any]
}
