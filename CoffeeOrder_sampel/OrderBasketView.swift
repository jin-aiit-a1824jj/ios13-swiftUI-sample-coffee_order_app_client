//
//  OrderBasketView.swift
//  CoffeeOrder_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import SwiftUI

struct OrderBasketView: View {
    
    @ObservedObject var basketListener = BasketListener()
    
    var body: some View {
        
        NavigationView {
            
            List{
                
                Section {
                    ForEach(self.basketListener.orderBasket?.items ?? []) { drink in
                        HStack {
                            Text(drink.name)
                            Text("$\(drink.price.clean)")
                        }
                    }//ForEach
                    .onDelete{ (indexSet) in
                        print("Delete as \(indexSet)")
                        self.deleteItems(as: indexSet)
                    }
                }//Section
                
                Section {
                    NavigationLink(destination: CheckoutView(), label: {Text("Place Order")})
                    
                }.disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
                //Section
                
            }//List
            .navigationBarTitle("Order")
            .listStyle(GroupedListStyle())
        }//NavigationView
        
    }
    
    func deleteItems(as offsets: IndexSet){
        self.basketListener.orderBasket.items.remove(at: offsets.first!)
        self.basketListener.orderBasket.saveBasketToFirestore()
    }
    
}

struct OrderBasketView_Previews: PreviewProvider {
    static var previews: some View {
        OrderBasketView()
    }
}
