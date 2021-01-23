//
//  ShoppingListTableViewCell.swift
//  ShoppingList
//
//  Created by Lee McCormick on 1/15/21.
//

import UIKit

// MARK: - Protocol
protocol ShowTableViewCellDelegate: AnyObject {
    func buttonPurchasedTapped(sender: ShoppingListTableViewCell)
}

class ShoppingListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var shoppingListButton: UIButton!
    @IBOutlet weak var shoppingListLabel: UILabel!
    
    // MARK: - Properties
    weak var delegate: ShowTableViewCellDelegate?
    
    var list: ShoppingList? {
        didSet {
            updateViewCellWith(list: list!)
        }
    }
    
    // MARK: - Actions
    @IBAction func shoppingListButtonTapped(_ sender: Any) {
        delegate?.buttonPurchasedTapped(sender: self)
    }
    
    // MARK: - Helper Fuctions
    func updateViewCellWith(list: ShoppingList) {
//                let lists = ShoppingListController.shared.lists
//                       var trueLists: [ShoppingList] = []
//                       var falseLists: [ShoppingList] = []
//        
//                           for list in lists {
//                               if list.havePurchased == true {
//                                   trueLists.append(list)
//                               } else {
//                                   falseLists.append(list)
//                               }
//                           }
//        
//                    let trueList = trueLists[indexPath.row]
//                    cell.updateViewCellWith(list: trueList)
//                } else {
//                    for list in lists {
//                        if list.havePurchased == false {
//                            falseLists.append(list)
//                        }
//                    }
//                    let  falseList =  falseLists[indexPath.row]
//
//                    cell.updateViewCellWith(list: falseList)
//
//                }
//
//        guard let list = list else { return }
//
//        if list.havePurchased {
//            shoppingListLabel.text = list.itemName
//        } else {
//            shoppingListLabel.text = list.itemName
//        }
        
        shoppingListLabel.text = list.itemName
        let imageButtonText = list.havePurchased ? "complete" : "incomplete"
        let imageButtonShow = UIImage(named: imageButtonText)
        shoppingListButton.setImage(imageButtonShow, for: .normal)
        
      //  let havePurschasedList = list.havePurchased ? 0 : 1
       // let section = havePurschasedList
        
        
//        let lists = ShoppingListController.shared.lists
//               var trueLists: [ShoppingList] = []
//               var falseLists: [ShoppingList] = []
//           
//                   for list in lists {
//                       if list.havePurchased == true {
//                           trueLists.append(list)
//                       } else {
//                           falseLists.append(list)
//                       }
//                   }

       
//            let trueList = trueLists[indexPath.row]
//            cell.updateViewCellWith(list: trueList)
//        } else {
//            for list in lists {
//                if list.havePurchased == false {
//                    falseLists.append(list)
//                }
//            }
//            let  falseList =  falseLists[indexPath.row]
//
//            cell.updateViewCellWith(list: falseList)
//
     //   }
        
        
        
        
        

        
    }
}

//// MARK: - Extenstion Delegate
//extension ShopingListTableViewController: ShowTableViewCellDelegate {
//    func buttonPurchasedTapped(sender: ShoppingListTableViewCell) {
//        guard let indexPath = tableView.indexPath(for: sender) else {return}
//        let listToToggle = ShoppingListController.shared.lists[indexPath.row]
//        ShoppingListController.shared.toggleHasPurchased(list: listToToggle)
//        sender.updateViewCellWith(list: listToToggle)
//    }
//}
