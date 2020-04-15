//
//  FUser.swift
//  CoffeeOrder_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import Foundation
import FirebaseAuth

class FUser {
    
    let id: String
    var email = ""
    var firstName = ""
    var lastName = ""
    var fullName = ""
    var phoneNumber = ""
    
    var fullAddress = ""
    var onBoarding = false
    
    init(_id: String, email: String, firstName: String, lastName: String, fullName: String, phoneNumber: String ){
        id = _id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = firstName + " " + lastName
        self.phoneNumber = phoneNumber
        onBoarding = false
    }
    
    class func currentId() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    class func currentUser() -> FUser? {
        if Auth.auth().currentUser != nil {
            if let dictionary = userDefaults.object(forKey: kCURRENTUSER) {
                return nil//FUser(_id: <#T##String#>, email: <#T##String#>, firstName: <#T##String#>, lastName: <#T##String#>, fullName: <#T##String#>, phoneNumber: <#T##String#>)
            }
        }
        return nil
    }
    
    class func loginUserWith(email: String, password: String, completion: @escaping (_ error: Error?, _ isEmailVerified: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password){ (authDataResult, error) in
            if error == nil {
                if authDataResult!.user.isEmailVerified {
                    
                } else {
                    completion(error, false)
                }
            }else {
                completion(error, false)
            }
        }
    }
    
    class func registerUserWith(email: String, password: String, completion: @escaping (_ error: Error?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password){  (authDataResult, error) in
            if error == nil {
                authDataResult!.user.sendEmailVerification { (error) in
                    print("verification email sent error is: ", error?.localizedDescription as Any)
                }
            }
        }
    }
}