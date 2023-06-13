//
//  TabBarPage.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 03.06.2023.
//

import SwiftUI

struct TabBarPage: View {
    
    @State private var selection = 1
    @EnvironmentObject var user : User
    @EnvironmentObject var db : FirestoreDB
    @Binding var screenState : Int
    
    var body: some View {
        TabView(selection: $selection) {
            CatalogPage()
                .environmentObject(db)
                .environmentObject(user)
                .tabItem {
                    Label("Catalog", systemImage: "house")
                }
                .tag(1)
            
            CartPage()
                .environmentObject(db)
                .environmentObject(user)
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .tag(2)
            ProfilePage(screenState: $screenState)
                .environmentObject(db)
                .environmentObject(user)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
                
        }
    }
}

