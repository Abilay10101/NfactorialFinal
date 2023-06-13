//
//  OneOrderPage.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 05.06.2023.
//

import SwiftUI

struct OneOrderPage: View {
    
    var order: Order
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                HStack {
                    Text("Ordered")
                        .padding()
                    Spacer()
                    Text(order.date)
                        .bold()
                        .padding()
                }.frame(height: 50)
                
                HStack {
                    Text("\(order.products.reduce(0) { $0 + $1.quantity }) items: Total (Including Delivery)")
                        .padding()
                    Spacer()
                    Text("$\(order.products.reduce(0) { $0 + ($1.price * $1.quantity) })")
                        .bold()
                        .padding()
                }.frame(height: 50)
                
                ForEach(order.products) { item in
                    HStack {
                        Image(item.imageURL)
                            .resizable()
                            .frame(width: 140,height: 140)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                        VStack(spacing: 2) {
                            HStack {
                                Text(item.name)
                                    .font(.system(size: 18, weight: .bold))
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            
                            HStack {
                                Text(item.description)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            
                            HStack {
                                Text("\(item.quantity) * $\(item.price)")
                                    .font(.system(size: 15, weight: .bold))
                                Spacer()
                            }
                            
                        }
                    }
                }
                
            }
        }
    }
}

