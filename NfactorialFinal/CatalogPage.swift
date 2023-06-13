//
//  CatalogPage.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 01.06.2023.
//

import SwiftUI

struct CatalogPage: View {
    
    @EnvironmentObject var db: FirestoreDB
    @EnvironmentObject var user: User
    
    var body: some View {
        VStack {
            Text("Hello, Sneakerhead!")
                .bold()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(db.products, id: \.id) { item in
                        CustomCell(id: item.id, image: item.imageURL, text: item.name, desc: item.description, price: item.price,  action: {
                            if let index = user.basket.firstIndex(where: { $0.id == item.id }) {
                                user.basket.remove(at: index)
                            } else {
                                user.basket.append(Product(id: item.id, docID: item.docID, name: item.name, price: item.price, description: item.description, imageURL: item.imageURL, quantity: 1, isTabbed: false))
                            }
                        }).environmentObject(db)
                        
                    }
                }
                .padding()
            }
        }.background(Color(red: 0.96, green: 0.96, blue: 0.96))
        
    }
}

