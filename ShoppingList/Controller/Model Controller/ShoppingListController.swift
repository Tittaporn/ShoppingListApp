//
//  ShoppingListController.swift
//  ShoppingList
//
//  Created by Lee McCormick on 1/15/21.
//

import Foundation

class ShoppingListController {
    
    // MARK: - Properties
    static let shared = ShoppingListController()
    var lists: [ShoppingList] = []
    var sections: [[ShoppingList]] {[notPurchasedLists, purchasedLists]}
    var notPurchasedLists: [ShoppingList] = []
    var purchasedLists: [ShoppingList] = []
    
    // MARK: - CRUD Methods
    func creatShoppingList(itemName: String) {
        let shoppingListName = ShoppingList(itemName: itemName, itemQuantity: 1)
        notPurchasedLists.append(shoppingListName)
        saveToPersistence()
    }
    
    func updateShoppingList(list: ShoppingList, itemName: String, itemQuantity: Int) {
        list.itemName = itemName
        list.itemQuantity = itemQuantity
        saveToPersistence()
    }
    
    func toggleHasPurchased(list: ShoppingList) {
        list.havePurchased = !list.havePurchased
        if list.havePurchased {
            if let index = notPurchasedLists.firstIndex(of: list) {
                notPurchasedLists.remove(at: index)
                purchasedLists.append(list)
            }
        } else {
            if let index = purchasedLists.firstIndex(of: list) {
                purchasedLists.remove(at: index)
                notPurchasedLists.append(list)
            }
        }
        saveToPersistence()
    }
    
    func deleteShoppingList(list: ShoppingList) {
        guard let listToDelete = lists.firstIndex(of: list) else {return}
        lists.remove(at: listToDelete)
        guard let purchasedListToDelete = purchasedLists.firstIndex(of: list) else{return}
        purchasedLists.remove(at: purchasedListToDelete)
        guard let notPurchasedToDelete = notPurchasedLists.firstIndex(of: list) else {return}
        notPurchasedLists.remove(at: notPurchasedToDelete)
        saveToPersistence()
        loadFromPersistance()
    }
    
    // MARK: - Persistence
    // CREATE
    func createFileForPersistence() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Shopping.json")
        return fileURL
    }
    
    // SAVE
    func saveToPersistence() {
        do {
            let data = try JSONEncoder().encode(lists)
            try data.write(to: createFileForPersistence())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    // LOAD
    func loadFromPersistance() {
        do {
            let data = try Data(contentsOf: createFileForPersistence())
            lists = try JSONDecoder().decode([ShoppingList].self, from: data)
            for list in lists {
                if list.havePurchased {
                    purchasedLists.append(list)
                } else {
                    notPurchasedLists.append(list)
                }
            }
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
