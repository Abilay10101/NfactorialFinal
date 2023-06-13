//
//  AuthPage.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 01.06.2023.
//

import SwiftUI
import Firebase

struct AuthPage: View {
    
    @EnvironmentObject var user: User
    @State var showAlert = false
    
    @Binding var screenState : Int
    @State var str1 = ""
    @State var str2 = ""
    
    var body: some View {
        VStack {
            CoolTextField(placeholderT: "Email", text1: $str1)
            PassTextField(placeholderT: "Password", text1: $str2)
            Spacer()
            MainButton(title: "Sign In") {
                login()
                
            }.alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Неверно введены поля"),
                    message: Text("Введите пожалуйста username и password"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: str1, password: str2) { result , error in
            if error != nil {
                print(error!.localizedDescription)
                showAlert.toggle()
            } else {
                user.email = str1
                user.password = str2
                screenState = 3
                user.fetchOrders()
            }
            
        }
    }
    
}
