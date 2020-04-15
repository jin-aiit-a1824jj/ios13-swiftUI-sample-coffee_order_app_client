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
    
    init(_id: String, email: String, firstName: String, lastName: String, phoneNumber: String ){
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
                    downloadUserFromFirestore(userId: authDataResult!.user.uid, email: email) { (error) in
                        completion(error, true)
                    }
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

func userDictionaryFrom(user: FUser) -> [String: Any] {
    return NSDictionary(objects: [
        user.id,
        user.email,
        user.firstName,
        user.lastName,
        user.fullName,
        user.phoneNumber,
        user.fullAddress,
        user.onBoarding
        ], forKeys: [
            kID as NSCopying,
            kEMAIL as NSCopying,
            kFIRSTNAME as NSCopying,
            kLASTNAME as NSCopying,
            kFULLNAME as NSCopying,
            kPHONENUMBER as NSCopying,
            kFULLADDRESS as NSCopying,
            kONBOARD as NSCopying
    ]) as!  [String: Any]
}

func saveUserToFirestore(fUser: FUser) {
    FirebaseReference(.User).document(fUser.id).setData(userDictionaryFrom(user: fUser)) { error in
        if error != nil {
            print("Error creating fuser object: ", error!.localizedDescription)
        }
    }
}

func saveUserLocally(userDictionary: NSDictionary) {
    userDefaults.set(userDictionary, forKey: kCURRENTUSER)
    userDefaults.synchronize()
}

func downloadUserFromFirestore(userId: String, email: String, completion: @escaping (_ error: Error?) -> Void) {
    FirebaseReference(.User).document(userId).getDocument{ (snapshot, error) in
        guard let snapshot = snapshot else { return }
        if snapshot.exists {
            saveUserLocally(userDictionary: snapshot.data()! as NSDictionary)
        }else {
            let user = FUser(_id: userId, email: email, firstName: "", lastName: "", phoneNumber: "")
            saveUserLocally(userDictionary: userDictionaryFrom(user: user) as NSDictionary)
            saveUserToFirestore(fUser: user)
        }
        completion(error)
    }
}


func updateCurrentUser(withValues: [String: Any], completion: @escaping (_ error: Error?) -> Void) {
    
    if let dictionary = userDefaults.object(forKey: kCURRENTUSER) {
        
        let userObject = (dictionary as! NSDictionary).mutableCopy() as! NSMutableDictionary
        userObject.setValuesForKeys(withValues)
        FirebaseReference(.User).document(FUser.currentId()).updateData(withValues){ error in
            completion(error)
            if error == nil {
                saveUserLocally(userDictionary: userObject)
            }
        }
        
    }

}
