//
//  ContentView.swift
//  CoffeeOrder_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var drinkListener = DrinkListener()
    
    var categories: [String : [Drink]]{
        .init(grouping: drinkListener.drinks, by: {$0.category.rawValue})
    }
    
    var body: some View {
        
        NavigationView{
            
            List(categories.keys.sorted(), id: \String.self) { key in
                DrinkRow(categoryName: "\(key) Drinks".uppercased(), drinks: self.categories[key]!)
                    .frame(height: 320)
                    .padding(.top)
                    .padding(.bottom)
            }
            
            .navigationBarTitle(Text("Coffee_sampel"))
            .navigationBarItems(
                leading:
                    Button(action: {
                        print("Log out")
                        
                    }, label: {Text("Log Out")}),
                trailing:
                    Button(action: {
                        print("Log out")
                        
                    }, label: {Text("Log Out")})
            )
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
