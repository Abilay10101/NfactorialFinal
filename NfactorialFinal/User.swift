//
//  User.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 03.06.2023.
//

import Foundation
import Firebase

class User: ObservableObject {
    @Published var id = 1
    @Published var email = ""
    @Published var password = ""
    @Published var shoeSize = 41
    @Published var basket = [Product]()
    @Published var orders = [Order]()
    
    init() {
        fetchOrders()
    }

    func makeOrder(order: Order) {
        let db = Firestore.firestore()
        let ref = db.collection("Orders")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"

        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        let orderData: [String: Any] = [
            "id" : self.orders.count + 1,
            "userEmail" : self.email,
            "date" : dateString,
            "products" : order.products.map { product in
                return [
                    "id" : product.id,
                    "docID" : product.docID,
                    "description" : product.description,
                    "imageURL" : product.imageURL,
                    "isTabbed" : product.isTabbed,
                    "name" : product.name,
                    "price" : product.price,
                    "quantity" : product.quantity
                ]
            }
        ]
        
        ref.addDocument(data: orderData)
    }
    
    func fetchOrders() {
        orders.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Orders")
        let query = ref.whereField("userEmail", isEqualTo: email)
        
        query.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    var productsArr = [Product]()
                    let data = document.data()
                    
                    let id = data["id"] as? Int ?? 1
                    let emailU = data["userEmail"] as? String ?? ""
                    let docID = document.documentID
                    let date = data["date"] as? String ?? ""
                    let products = data["products"] as? [[String : Any]] ?? []
                    
                    for product in products {
                        let id = product["id"] as? Int ?? 1
                        let docID = product["docID"] as? String ?? ""
                        let description = product["description"] as? String ?? ""
                        let imageURL = product["imageURL"] as? String ?? ""
                        let isTabbed = product["isTabbed"] as? Bool ?? false
                        let name = product["name"] as? String ?? ""
                        let price = product["price"] as? Int ?? 1
                        let quantity = product["quantity"] as? Int ?? 1
                        
                        let product = Product(id: id, docID: docID, name: name, price: price, description: description, imageURL: imageURL, quantity: quantity, isTabbed: isTabbed)
                        productsArr.append(product)
                    }
                    
                    let order = Order(id: id, email: emailU, docID: docID, date: date, products: productsArr)
                    self.orders.append(order)
                }
            }
            print(self.orders)
            
        }
    }
    
}

