//
//  Extensions.swift
//  CoffeeOrder_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import Foundation

extension Double {
    var clean: String{
        return self.truncatingRemainder(dividingBy: 1) ==  0 ? String(format: "%.0f", self) : String(self)
    }
}
