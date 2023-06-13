//
//  ImmitationOfDB.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 03.06.2023.
//

import Foundation
import Firebase

class FirestoreDB: ObservableObject {
    
    @Published var products : [Product] = []
    
    init() {
        fetchProducts()
    }
    
    func updateQuantityProduct(updatePrts: [Product]) {
        let db = Firestore.firestore()
        
        for product in products {
            for updatePrt in updatePrts {
                if product.docID == updatePrt.docID {
                    db.collection("Products").document(updatePrt.docID).setData(["quantity" : (product.quantity - updatePrt.quantity)] , merge: true)
                }
            }
        }
    }
    
    
    func fetchProducts () {
        products.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Products")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? Int ?? 1
                    let docID = document.documentID
                    let description = data["description"] as? String ?? ""
                    let imageURL = data["imageURL"] as? String ?? ""
                    let isTabbed = data["isTabbed"] as? Bool ?? false
                    let name = data["name"] as? String ?? ""
                    let price = data["price"] as? Int ?? 1
                    let quantity = data["quantity"] as? Int ?? 1
                    
                    let product = Product(id: id, docID: docID, name: name, price: price, description: description, imageURL: imageURL, quantity: quantity, isTabbed: isTabbed)
                    self.products.append(product)
                }
            }
            
        }
    }
}
