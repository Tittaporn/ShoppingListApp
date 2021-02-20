//
//  ShopingListTableViewController.swift
//  ShoppingList
//
//  Created by Lee McCormick on 1/15/21.
//

import UIKit

class ShopingListTableViewController: UITableViewController {
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ShoppingListController.shared.loadFromPersistance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ShoppingListController.shared.loadFromPersistance()
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func addShoppingBarButtonTapped(_ sender: Any) {
        presetAlertToAddList()
    }
    
    // MARK: - Helper Fuctions
    func  presetAlertToAddList() {
        let alert = UIAlertController(title: "Add Shopping List.", message: "Please, input your list here...", preferredStyle: .alert)
        let addButton = UIAlertAction(title: "Add", style: .default) { (action) in
            guard let newList = alert.textFields?[0].text, !newList.isEmpty else {return}
            ShoppingListController.shared.creatShoppingList(itemName: newList)
            self.tableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField{ (_) in}
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ShoppingListController.shared.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingListController.shared.sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingListCell", for: indexPath) as? ShoppingListTableViewCell else {return UITableViewCell()}
        
        
        let list = ShoppingListController.shared.sections[indexPath.section][indexPath.row]
        
        cell.list = list
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let listToDelete = ShoppingListController.shared.sections[indexPath.section][indexPath.row]
            ShoppingListController.shared.deleteShoppingList(list: listToDelete)
            tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            if ShoppingListController.shared.notPurchasedLists.count == 0 {
                return CGFloat(0.0)
            } else {
                return CGFloat(50.0)
            }
        } else  {
            if ShoppingListController.shared.purchasedLists.count == 0 {
                return CGFloat(0.0)
            } else {
                return CGFloat(50.0)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if ShoppingListController.shared.notPurchasedLists.count == 0 {
                return ""
            }
            return "NOT PURCHASED LISTS"
        } else  {
            if ShoppingListController.shared.purchasedLists.count == 0 {
                return ""
            }
            return "PURCHASED LISTS"
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.yellow
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.brown
        header.textLabel?.font = UIFont(name: "Apple Color Emoji", size: 20)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShopingListDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? ShoppingListDetailViewController else {return}
            let list = ShoppingListController.shared.sections[indexPath.section][indexPath.row]
            destination.list = list
        }
    }
}

// MARK: - Extenstion Delegate
extension ShopingListTableViewController: ShowTableViewCellDelegate {
    func buttonPurchasedTapped(sender: ShoppingListTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let listToToggle = ShoppingListController.shared.sections[indexPath.section][indexPath.row]
        ShoppingListController.shared.toggleHasPurchased(list: listToToggle)
        sender.updateViewCellWith(list: listToToggle)
        tableView.reloadData()
    }
}
