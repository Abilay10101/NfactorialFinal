//
//  NfactorialFinalApp.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 31.05.2023.
//

import SwiftUI
import Firebase

@main
struct NfactorialFinalApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainPage()
        }
    }
}
