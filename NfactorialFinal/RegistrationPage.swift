//
//  RegistrationPage.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 01.06.2023.
//

import SwiftUI
import Firebase

struct RegistrationPage: View {
    
    @EnvironmentObject var user: User
    @Binding var screenState : Int
    
    @State var str1 = ""
    @State var str2 = ""
    @State var str3 = ""
    @State var showAlert = false
    
    var body: some View {
        VStack {
            CoolTextField(placeholderT: "Email", text1: $str1)
            PassTextField(placeholderT: "Password", text1: $str2)
            PassTextField(placeholderT: "Repeat password", text1: $str3)
            Spacer()
            MainButton(title: "Sign Up") {
                if str1 == "" || str2 == "" || str3 == "" || str1.count < 4 || str2 != str3 || str2.count < 6 {
                    showAlert.toggle()
                }else {
                    register()
                    user.email = str1
                    user.password = str2
                    screenState = 3
                    user.fetchOrders()
                }
                
            }.alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Неверно введены поля"),
                    message: Text("Введите пожалуйста username и password"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: str1, password: str2) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
}
