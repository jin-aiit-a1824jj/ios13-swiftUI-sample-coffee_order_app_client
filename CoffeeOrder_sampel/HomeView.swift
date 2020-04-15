//
//  ContentView.swift
//  CoffeeOrder_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        NavigationView{
            Text("Hello, World!")
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
