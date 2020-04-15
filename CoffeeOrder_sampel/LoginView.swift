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
                    .animation(.easeInOut(duration: 0.1))
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
                print(self.showingSignup ? "Sign Up" : "Sign In")
                self.showingSignup ? self.signUpUser() : self.loginUser()
            }, label: {
                Text(showingSignup ? "Sign Up" : "Sign In")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 120)
                    .padding()
            })
                .background(Color.blue)
                .clipShape(Capsule())
                .padding(.top, 45)
            
            SignUpView(showingSignup: $showingSignup)
        
        }//VStack
    }
    
    private func loginUser(){
        
    }

    private func signUpUser(){
        
    }
    
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct SignUpView : View{
    
    @Binding var showingSignup: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 8, content: {
                
                Text("Don't  have an Account?").foregroundColor(Color.gray.opacity(0.5))
                    
                Button(action: {
                    print("Sign Up")
                    self.showingSignup.toggle()
                }, label: {
                    Text("Sign up")
                        .foregroundColor(.blue)
                })
                
            }).padding(.top, 25) //HStack
        }//VStack
    }
    
}