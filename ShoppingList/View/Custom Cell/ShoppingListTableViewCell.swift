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
        shoppingListLabel.text = list.itemName
        let imageButtonText = list.havePurchased ? "complete" : "incomplete"
        let imageButtonShow = UIImage(named: imageButtonText)
        shoppingListButton.setImage(imageButtonShow, for: .normal)
    }
}
