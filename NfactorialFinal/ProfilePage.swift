//
//  ProfilePage.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 02.06.2023.
//

import SwiftUI
import Firebase

struct ProfilePage: View {
    
    @EnvironmentObject var db: FirestoreDB
    @EnvironmentObject var user: User
    
    @State var openAccInf = false
    @State var ordHistory = false
    @State var shoeSizePage = false
    @State var showAlert = false
    
    @Binding var screenState : Int
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                
                NavigationLink(isActive: $openAccInf) {
                    ProfAccountPage(openAccInf: $openAccInf)
                        .environmentObject(user)
                } label: {
                     ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(height: 45)
                            .foregroundColor(.white)
                        HStack {
                            Text("Account Information")
                                .padding(.horizontal)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                        }
                     }.onTapGesture {
                         openAccInf.toggle()
                     }
                }
                
                
                NavigationLink(isActive: $ordHistory) {
                    OrderHistoryPage()
                        .environmentObject(user)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(height: 45)
                            .foregroundColor(.white)
                        HStack {
                            Text("Order History")
                                .padding(.horizontal)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                        }
                    }.onTapGesture {
                        ordHistory.toggle()
                     }
                }
                
                NavigationLink(isActive: $shoeSizePage) {
                    ShoeSizePage(shoeSizePage: $shoeSizePage)
                        .environmentObject(user)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(height: 45)
                            .foregroundColor(.white)
                        HStack {
                            Text("Shoe size")
                                .padding(.horizontal)
                            Spacer()
                            
                            Text("\(user.shoeSize)")
                                .foregroundColor(.gray)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                    }.onTapGesture {
                         shoeSizePage.toggle()
                     }
                }
                
                
                
                Spacer()
                
                MainButton(title: "Sign out") {
                    showAlert.toggle()
                }.padding(.bottom)
                .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Are you sure you want to sign out?"),
                            primaryButton: .default(Text("Confirm")) {
                                try? Auth.auth().signOut()
                                user.email = ""
                                user.password = ""
                                user.basket = []
                                user.orders = []
                                screenState = 2
                            },
                            secondaryButton: .default(Text("Cancel"))
                            
                        )
                    }
            }.navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .background(Color(red: 0.96, green: 0.96, blue: 0.96))
        }
        
    }
}
