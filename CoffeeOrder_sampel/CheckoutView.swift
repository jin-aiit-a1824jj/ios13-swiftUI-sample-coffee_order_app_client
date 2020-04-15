//
//  CheckoutView.swift
//  CoffeeOrder_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var basketListener = BasketListener()
    
    static let paymentTypes = ["Cash", "Credit Card"]
    static let tipAmounts = [10, 15, 20, 0]
    
    @State private var paymentType = 0
    @State private var tipAmount = 1
    @State private var showingPaymentAlert = false

    var totalPrice : Double {
        let total = basketListener.orderBasket.total
        let tipValue = total / 100 * Double(CheckoutView.self.tipAmounts[tipAmount])
        return total + tipValue
    }
    
    var body: some View {
        
        Form {
            
            Section{
                Picker(selection: $paymentType, label: Text("How do you want to pay"), content: {
                    ForEach(0 ..< Self.paymentTypes.count){
                        Text(Self.paymentTypes[$0])
                    }
                })
            }//Section
            
            Section (header: Text("Add a tip?"), content:{
                Picker(selection: $tipAmount, label: Text("Percentage: "), content: {
                    ForEach( 0 ..< Self.tipAmounts.count){ value in
                        Text("\(Self.tipAmounts[value]) %")
                    }
                })
                .pickerStyle(SegmentedPickerStyle())
            })//Setion
            
            Section (header:
                Text("Total: $\(totalPrice, specifier: "%.2f")").font(.largeTitle),
                     content:{
                Button(action: {
                    print("Check out")
                }, label: { Text("Confirm Order") })
                })
                .disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
            //Setion
            
        }//Form
         .navigationBarTitle(Text("Payment"), displayMode: .inline)
        
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
