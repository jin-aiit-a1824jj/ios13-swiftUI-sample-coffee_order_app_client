//
//  LoginView.swift
//  CoffeeOrder_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    @State var repeatPassword = ""
    @State var showingSignup = false
    
    var body: some View {
        VStack {
            Text("Sign In")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.bottom, .top], 20)
            
            VStack(alignment: .leading, content: {
                VStack(alignment: .leading, content: {
                    Text("Email ")
                                   .fontWeight(.light)
                                   .font(.headline)
                                   .foregroundColor(Color.init(.label))
                                   .opacity(0.75)
                               
                               TextField("Enter yout email", text: $email)
                               Divider()
                               
                               Text("Password ")
                                   .fontWeight(.light)
                                   .font(.headline)
                                   .foregroundColor(Color.init(.label))
                                   .opacity(0.75)
                               
                               SecureField("Enter yout password", text: $password)
                               Divider()
                               
                               if showingSignup {
                                   Text("Repeat Password ")
                                       .fontWeight(.light)
                                       .font(.headline)
                                       .foregroundColor(Color.init(.label))
                                       .opacity(0.75)
                                   
                                   SecureField("Repeat password", text: $repeatPassword)
                                   Divider()
                               }
                }).padding(.bottom, 15)
                //VStack
            
                HStack {
                    Spacer()
                    Button(action: {
                        print("Forgot Password?")
                    }, label: {
                        Text("Forgot Password?")
                            .foregroundColor(Color.gray.opacity(0.5))
                    })
                }
            
            }).padding(.horizontal, 6)
            //VStack
            
            Button(action: {
                print("Sign In")
            }, label: {
                Text("Sign In")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 120)
                    .padding()
                })
                .background(Color.blue)
                .clipShape(Capsule())
                .padding(.top, 45)
            
        }//VStack
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
