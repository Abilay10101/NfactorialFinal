//
//  OrderHistoryPage.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 02.06.2023.
//

import SwiftUI

struct OrderHistoryPage: View {
    
    @EnvironmentObject var db: FirestoreDB
    @EnvironmentObject var user: User
    
    @State var openCell = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(user.orders) { item in
                    
                    NavigationLink(isActive: $openCell) {
                        OneOrderPage(order: item)
                    } label: {
                        HStack {
                            Image("OrdImg")
                                .resizable()
                                .frame(width: 120,height: 100)
                            VStack(spacing: 2) {
                                
                                HStack {
                                    Text("Order #\(item.id)")
                                        .bold()
                                        .font(.system(size: 20))
                                    Spacer()
                                }
                                
                                HStack {
                                    Text(item.date)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 16))
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("\(item.products.reduce(0) { $0 + $1.quantity }) items : Total $\(item.products.reduce(0) { $0 + ($1.price * $1.quantity) })")
                                        .font(.system(size: 16))
                                        .padding(.vertical, 10)
                                    Spacer()
                                }
                                
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding()
                        }.onTapGesture {
                            openCell.toggle()
                         }
                    }
                    
                    
                }
            }
        }
    }
}

struct OrderHistoryPage_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryPage()
    }
}
