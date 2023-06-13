//
//  MainPage.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 03.06.2023.
//

import SwiftUI

struct MainPage: View {
    
    @StateObject var db = FirestoreDB()
    @StateObject var user = User()
    @State var screenState = 1
    
    var body: some View {
        if screenState == 1 {
            OnboardingPage(screenState: $screenState)
        } else if screenState == 2 {
            WelcomePage(screenState: $screenState)
                .environmentObject(user)
        } else if screenState == 3 {
            TabBarPage(screenState: $screenState)
                .environmentObject(user)
                .environmentObject(db)
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
