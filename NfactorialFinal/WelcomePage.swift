//
//  WelcomePage.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 01.06.2023.
//

import SwiftUI

struct WelcomePage: View {
    
    @Binding var screenState : Int
    @EnvironmentObject var user : User
    
    @State var openReg = false
    @State var openAuth = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Image("WImg1")
                    .resizable()
                    .frame(width: 420,height: 350)
                    .position(x: 190,y: 120)
                Image("WImg2")
                    .resizable()
                    .frame(width: 228,height: 228)
                    .position(x: 114, y: 230)
                Image("WImg3")
                    .resizable()
                    .frame(width: 246,height: 246)
                    .position(x: 270, y: -40)
                
                
                MainTitle(title: "Welcome to the biggest sneakers store app", color: .black)
                
                NavigationLink(isActive: $openReg) {
                    RegistrationPage(screenState: $screenState)
                        .environmentObject(user)
                } label: {
                    MainButton(title: "Sign Up") {
                        openReg.toggle()
                    }
                }
                
                NavigationLink(isActive: $openAuth) {
                    AuthPage(screenState: $screenState)
                        .environmentObject(user)
                } label: {
                    Text("I already have an account")
                        .font(.system(size: 17))
                        .padding()
                        .onTapGesture {
                            openAuth.toggle()
                        }
                }
                
            }
        }
        
    }
}
