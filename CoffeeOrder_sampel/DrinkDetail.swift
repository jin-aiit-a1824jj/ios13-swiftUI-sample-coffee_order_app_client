//
//  DrinkDetail.swift
//  CoffeeOrder_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import SwiftUI

struct DrinkDetail: View {
    
    @State private var showingLogin = false
    @State private var showingAlert = false
    
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
            .listRowInsets(EdgeInsets())
            Text(drink.description)
                .foregroundColor(.primary)
                .font(.body)
                .lineLimit(5)
                .padding()
            HStack {
                Spacer()
                OrderButton(showAlert:  $showingAlert, showLogin: $showingLogin,  drink: self.drink)
                Spacer()
            }.padding(.top, 50)
            
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("Added to Basket!"), dismissButton: .default(Text("OK")))
        })
    }
    
}

struct DrinkDetail_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetail(drink: drinkData.first!)
    }
}

struct OrderButton : View {
    
    @ObservedObject var basketListener = BasketListener()
    @Binding var showAlert: Bool
    @Binding var showLogin: Bool
    
    var drink: Drink
    
    var body : some View {
        Button(
            action: {
                print("Add to Basket, \(self.drink.name)")
                
                if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                    self.showAlert.toggle()
                    self.addItemToBasket()
                } else {
                    self.showLogin.toggle()
                }
                
        },
            label: { Text("Add to Basket") }
        )
        .frame(width: 200, height: 50)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.blue)
        .cornerRadius(10)
        .sheet(isPresented: $showLogin, content: {
            if FUser.currentUser() != nil {
                FinishRegistrationView()
            }else {
                LoginView()
            }
        })
    }
    
    private func addItemToBasket() {
        var orderBasket: OrderBasket!
        
        if self.basketListener.orderBasket != nil {
            orderBasket = self.basketListener.orderBasket
        } else {
            orderBasket = OrderBasket()
            orderBasket.ownerId = "123"
            orderBasket.id = UUID().uuidString
        }
        
        orderBasket.add(self.drink)
        orderBasket.saveBasketToFirestore()
    }
}
