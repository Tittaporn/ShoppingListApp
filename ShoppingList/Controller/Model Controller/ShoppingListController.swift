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
    
    // MARK: - CRUD Methods
    func creatShoppingList(itemName: String) {
        let shoppingListName = ShoppingList(itemName: itemName, itemQuantity: 1)
        lists.append(shoppingListName)
        saveToPersistence()
    }
    
    func updateShoppingList(list: ShoppingList, itemName: String, itemQuantity: Int) {
        list.itemName = itemName
        list.itemQuantity = itemQuantity
        saveToPersistence()
    }
    
    func deleteShoppingList(listToDelete: ShoppingList) {
        guard let listToDelete = lists.firstIndex(of: listToDelete) else {return}
        lists.remove(at: listToDelete)
        saveToPersistence()
    }
    
    func toggleHasPurchased(list: ShoppingList) {
        list.havePurchased = !list.havePurchased
        saveToPersistence()
    }
    
    
    
    // MARK: - Persistence
    // CREATE
    func createFileForPersistence() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("ShoppingList.json")
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
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
