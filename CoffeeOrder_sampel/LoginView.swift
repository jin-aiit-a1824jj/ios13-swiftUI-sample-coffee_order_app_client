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
    @State var showingFinishReg = false

    @Environment(\.presentationMode) var presentationMode
    
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
                        self.resetPassword()
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
        .sheet(isPresented: $showingFinishReg, content: {
            FinishRegistrationView()
        })
    }
    
    private func loginUser() {
        if email != "" && password != ""  {
            FUser.loginUserWith(email: email, password: password) { (error, isEmailVerified) in
                if error != nil {
                    print("error loging in the user: ", error!.localizedDescription)
                    return
                }
                
                print("user login successful, email is verfied: ", isEmailVerified)
                
                if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showingFinishReg.toggle()
                }
                
            }
        }
    }

    private func signUpUser() {
        
        if email != "" && password != "" && repeatPassword != "" {
            if password == repeatPassword {
                
                FUser.registerUserWith(email: email, password: password) { (error) in
                    if error != nil {
                        print("Error registering user: ", error!.localizedDescription)
                        return
                    }
                    print("User has been created")
                }
            }else {
                print("password and  repeatPassword  do not match")
            }
            
        }else {
            print("Email and password must be set")
        }
        

    }
    
    private func resetPassword() {
        
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
