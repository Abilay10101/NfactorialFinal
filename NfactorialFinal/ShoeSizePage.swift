//
//  ShoeSizePage.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 02.06.2023.
//

import SwiftUI

struct ShoeSizePage: View {
    
    @EnvironmentObject var user: User
    
    @Binding var shoeSizePage : Bool
    
    @State var num1 = 1
    
    var body: some View {
        VStack {
            NumTextField(placeholderT: "41", num: $num1)
            Spacer()
            MainButton(title: "Save changes") {
                user.shoeSize = num1
                shoeSizePage = false 
            }
        }.navigationTitle("Shoe Size")
            .navigationBarTitleDisplayMode(.inline)
    }
}

