//
//  Order.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 05.06.2023.
//

import Foundation

struct Order: Identifiable, Hashable{
    var id: Int
    var email: String
    var docID: String
    var date: String
    var products: [Product]
}
