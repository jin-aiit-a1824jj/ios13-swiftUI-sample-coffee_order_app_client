//
//  FinishRegistrationView.swift
//  CoffeeOrder_sampel
//
//  Created by JONGWOO JIN on 2020/04/15.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import SwiftUI

struct FinishRegistrationView: View {
    
    @State var name = ""
    @State var surname = ""
    @State var telephone = ""
    @State var address = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form{
            
            Section(){
                
                Text("Finish Registration")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding([.top, .bottom], 20)
                
                TextField("Name", text: $name)
                TextField("Surname", text: $surname)
                TextField("Telephone", text: $telephone)
                TextField("Address", text: $address)
                
            }//Section
            
            Section() {
                Button(action: {
                    print("Finish Registration")
                    self.finishRegistration()
                }, label: {
                    Text("Finish Registration")
                })
            }.disabled(!self.fieldsCompleted())
            //Section
            
        }//Form
    }
    
    private func fieldsCompleted() -> Bool {
        return !self.name.isEmpty &&
                    !self.surname.isEmpty &&
                    !self.telephone.isEmpty &&
                    !self.address.isEmpty
    }
    
    private func finishRegistration() {
        let fullName = name + " " + surname
        updateCurrentUser(withValues: [kFIRSTNAME : name,
                                                        kLASTNAME: surname,
                                                        kFULLNAME: fullName,
                                                        kFULLADDRESS: address,
                                                        kPHONENUMBER : telephone,
                                                        kONBOARD : true] ) {error in
                                                            if error != nil {
                                                                print("error updating user: ", error!.localizedDescription)
                                                                return
                                                            }
                                                            
                                                            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
}

struct FinishRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        FinishRegistrationView()
    }
}
