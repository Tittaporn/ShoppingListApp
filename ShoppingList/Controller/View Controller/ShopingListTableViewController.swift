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
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRowForEachSection = 0
        if section == 1 {
            let purchasedLists = ShoppingListController.shared.lists
            for list in purchasedLists {
                if list.havePurchased == true {
                numberOfRowForEachSection += 1
                }
            }
        } else if section == 0 {
            let notPurchasedLists = ShoppingListController.shared.lists
            for list in notPurchasedLists {
                if list.havePurchased == false {
                numberOfRowForEachSection += 1
                }
            }
        }
        
        print(numberOfRowForEachSection)
        return numberOfRowForEachSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let cellTitle = mySectionsList[indexPath.section][indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingListCell", for: indexPath) as? ShoppingListTableViewCell else {return UITableViewCell()}
        
        
        let lists = ShoppingListController.shared.lists
        var trueLists: [ShoppingList] = []
        var falseLists: [ShoppingList] = []
        
        if indexPath.section == 1  {
            for list in lists {
                if list.havePurchased == true {
                    trueLists.append(list)
                }
            }
            let trueList = trueLists[indexPath.row]
            //cell.updateViewCellWith(list: trueList)
            cell.list = trueList
        } else {
            for list in lists {
                if list.havePurchased == false {
                    falseLists.append(list)
                }
            }
            let  falseList =  falseLists[indexPath.row]
            
           // cell.updateViewCellWith(list: falseList)
            cell.list = falseList
            
        }
        
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "FontName", size: 14)
    }
    
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return ["Have not purchased items", "Have purchased items."]
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let listToDelete = ShoppingListController.shared.lists[indexPath.row]
            ShoppingListController.shared.deleteShoppingList(listToDelete: listToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShopingListDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? ShoppingListDetailViewController else {return}
            let list = ShoppingListController.shared.lists[indexPath.row]
            destination.list = list
        }
    }
}

// MARK: - Extenstion Delegate
extension ShopingListTableViewController: ShowTableViewCellDelegate {
    func buttonPurchasedTapped(sender: ShoppingListTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let listToToggle = ShoppingListController.shared.lists[indexPath.row]
        ShoppingListController.shared.toggleHasPurchased(list: listToToggle)
        sender.updateViewCellWith(list: listToToggle)
    }
}


/*
 https://www.youtube.com/watch?v=zFMSovtqqUc
 */
