//
//  FirebaseReference.swift
//  CoffeeOrder_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FCollectionReferenc: String {
    case User
    case Menu
    case Order
    case Basket
}

func FirebaseReference(_ collectionReference: FCollectionReferenc) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
