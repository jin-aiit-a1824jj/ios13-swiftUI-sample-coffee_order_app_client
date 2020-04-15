//
//  DrinkDetail.swift
//  CoffeeOrder_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import SwiftUI

struct DrinkDetail: View {
    
    var drink: Drink
    
    var body: some View {
        ScrollView(.vertical, showsIndicators:  false) {
            ZStack(alignment: .bottom, content: {
                Image(drink.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Rectangle()
                    .frame(height: 80)
                    .foregroundColor(.black)
                    .opacity(0.35)
                    .blur(radius: 10)
                
                HStack {
                    VStack(alignment: .leading, spacing: 8, content: {
                        Text(drink.name)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    })
                    .padding(.leading)
                    .padding(.bottom)
                    
                    Spacer()
                }
            })
        }
    }
}

struct DrinkDetail_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetail(drink: drinkData.first!)
    }
}
