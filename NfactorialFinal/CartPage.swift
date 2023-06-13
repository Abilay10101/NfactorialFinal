//
//  CartPage.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 01.06.2023.
//

import SwiftUI
import Firebase

struct CartPage: View {
    
    @EnvironmentObject var db: FirestoreDB
    @EnvironmentObject var user: User
    @State var showAlert = false
    
    @State var showModal = false
    @State var showSheetModal = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if !user.basket.isEmpty {
                    
                    VStack {
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(user.basket) { item in
                                    HStack {
                                        Image(item.imageURL)
                                            .resizable()
                                            .frame(width: 140, height: 140)
                                            .padding(.horizontal)
                                            .padding(.vertical, 10)
                                        
                                        VStack(spacing: 2) {
                                            HStack {
                                                Text(item.name)
                                                //.font(.headline)
                                                    .font(.system(size: 15, weight: .bold))
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
                                                Text("$\(item.price)")
                                                    .font(.system(size: 15, weight: .bold))
                                                Spacer()
                                            }
                                            
                                            
                                            HStack {
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .frame(width: 166,height: 40)
                                                        .foregroundColor(.black)
                                                    HStack {
                                                        
                                                        
                                                        Button(action: {
                                                            if let index = user.basket.firstIndex(where: { $0.id == item.id }) {
                                                                user.basket[index].quantity -= 1
                                                                
                                                                if user.basket[index].quantity == 0 {
                                                                    deleteItem(item)
                                                                }
                                                            }
                                                        }) {
                                                            
                                                            Image(systemName: "minus")
                                                                .foregroundColor(.white)
                                                            
                                                        }
                                                        
                                                        Text("\(item.quantity)")
                                                            .padding(.horizontal, 10)
                                                            .foregroundColor(.white)
                                                        
                                                        Button(action: {
                                                            if let index = user.basket.firstIndex(where: { $0.id == item.id }) {
                                                                user.basket[index].quantity += 1
                                                            }
                                                        }) {
                                                            
                                                            Image(systemName: "plus")
                                                                .foregroundColor(.white)
                                                            
                                                        }
                                                    }
                                                }
                                            }.padding(.vertical, 8)
                                                
                                        }
  
                                    }.background(.white)
                               
                                }
                                
                                ZStack {
                                    Rectangle()
                                        .frame(height: 50)
                                        .foregroundColor(.white)
                                    HStack {
                                        Text("\(user.basket.reduce(0) { $0 + $1.quantity }) items: Total (Including Delivery)")
                                            .padding()
                                        Spacer()
                                        Text("$\(user.basket.reduce(0) { $0 + ($1.price * $1.quantity) })")
                                            .padding()
                                    }
                                }
                            }
                        }
                        
                        
                        MainButton(title: "Confirm Order") {
                            showAlert.toggle()
                        }.alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Proceed with payment"),
                                message: Text("Are you sure you want to confirm?"),
                                primaryButton: .default(Text("Confirm")) {
                                    showModal.toggle()
                                    showSheetModal.toggle()
                                    db.updateQuantityProduct(updatePrts: user.basket)
                                    user.makeOrder(order: Order(id: 0, email: "", docID: "", date: "", products: user.basket))
                                    user.fetchOrders()
                                },
                                secondaryButton: .default(Text("Cancel"))
                                
                            )
                        }
                        .animation(.spring(), value: 1)
                        .padding(.vertical)
                            
                    }
                } else {
                    VStack {
                        Image("WImg1")
                            .resizable()
                            .frame(width: 420,height: 350)
                            .offset(x: 0,y: -50)
                        
                        MainTitle(title: "Cart is empty", color: .black)
                        Text("Find interesting models in the Catalog.")
                        Spacer()
                        Spacer()
                        
                        
                    }
                }
                
                if showModal {
                    Rectangle()
                        .opacity(0.5)
                        .ignoresSafeArea()
                    
                    VStack {
                        HStack {
                            Spacer()
                        }.frame(height: 230)
                        ThModal {
                            deleteAllItems()
                            showModal.toggle()
                        }
                        .zIndex(1)
                        .ignoresSafeArea()
                            
                    }
                }
            }.background(Color(red: 0.96, green: 0.96, blue: 0.96))
            .navigationBarTitle("Cart")
            .navigationBarTitleDisplayMode(.inline)
            
            
        }
        
    }
    
    func deleteItem(_ item: Product) {
        if let index = user.basket.firstIndex(where: { $0.id == item.id }) {
            user.basket.remove(at: index)
        }
    }
    
    func deleteAllItems() {
        user.basket.removeAll()
    }
    
}

