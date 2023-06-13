//
//  Product.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 01.06.2023.
//

import Foundation

struct Product: Identifiable, Hashable {
    let id: Int
    let docID: String
    let name: String
    let price: Int
    let description: String
    let imageURL: String
    var quantity: Int
    var isTabbed: Bool
}
