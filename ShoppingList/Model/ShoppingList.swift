//
//  ShoppingList.swift
//  ShoppingList
//
//  Created by Lee McCormick on 1/15/21.
//

import Foundation

class ShoppingList: Codable {
    var itemName: String
    var havePurchased: Bool
    var itemQuantity: Int
    
    init(itemName: String, hasPurchased: Bool = false, itemQuantity: Int) {
        self.itemName = itemName
        self.havePurchased = hasPurchased
        self.itemQuantity = itemQuantity
    }
}

extension ShoppingList: Equatable {
    static func == (lhs: ShoppingList, rhs: ShoppingList) -> Bool {
        lhs.itemName == rhs.itemName && lhs.havePurchased == rhs.havePurchased && lhs.itemQuantity == rhs.itemQuantity
    }
}
