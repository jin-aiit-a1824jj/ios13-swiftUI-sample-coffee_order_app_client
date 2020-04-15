//
//  DrinkItem.swift
//  CoffeeOrder_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import SwiftUI

struct DrinkItem: View {
    
    var drink: Drink
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16, content: {
            Image(drink.imageName)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 170)
                .cornerRadius(10)
                .shadow(radius: 10)
            
            VStack(alignment: .leading, spacing: 5, content: {
                Text(drink.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                
                Text(drink.description)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .lineLimit(2)
                    .frame(height: 40)
            })
        })
        
    }
}

struct DrinkItem_Previews: PreviewProvider {
    static var previews: some View {
        DrinkItem(drink: drinkData[0])
    }
}
