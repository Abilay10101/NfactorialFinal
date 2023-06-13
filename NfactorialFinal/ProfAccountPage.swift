//
//  ProfAccountPage.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 02.06.2023.
//

import SwiftUI
import Firebase

struct ProfAccountPage: View {
    
    @EnvironmentObject var user: User
    
    @Binding var openAccInf : Bool
    
    @State var str1 = ""
    @State var str2 = ""
    @State var str3 = ""
    
    @State var showAlert = false
    
    var body: some View {
        VStack {
            CoolTextField(placeholderT: "Username", text1: $str1)
            CoolTextField(placeholderT: "Password", text1: $str2)
            CoolTextField(placeholderT: "Repeat password", text1: $str3)
            Spacer()
            MainButton(title: "Save changes") {
                if str1 == "" || str2 == "" || str3 == "" || str1.count < 4 || str2 != str3 || str2.count < 6 {
                    showAlert.toggle()
                } else {
                    guard let user1 = Auth.auth().currentUser else { return }
                    let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: user.password )
                    
                    user1.reauthenticate(with: credential) { _,error in
                        if let error = error {
                            print("error")
                        } else {
                            user1.updateEmail(to: str1) { error in
                                if let error = error {
                                    print("error")
                                } else {
                                    user1.updatePassword(to: str2) { error in
                                        if let error = error {
                                            print("error")
                                        } else {
                                            // Email and password updated 
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                    
                    user.email = str1
                    user.password = str2
                    openAccInf = false
                    
                }
            }.padding(.bottom)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Неверно введены поля"),
                    message: Text("Введите пожалуйста username и password"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }.navigationTitle("Account Information")
            .navigationBarTitleDisplayMode(.inline)
        
    }
}
