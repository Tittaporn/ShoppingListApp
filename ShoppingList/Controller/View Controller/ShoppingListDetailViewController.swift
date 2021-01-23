//
//  ShoppingListDetailViewController.swift
//  ShoppingList
//
//  Created by Lee McCormick on 1/15/21.
//

import UIKit

class ShoppingListDetailViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var itemNameTextFiled: UITextField!
    @IBOutlet weak var havePurchasedButton: UIButton!
    
    // MARK: - Properties
    var list: ShoppingList?
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        quantityTextField.delegate = self
        itemNameTextFiled.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func doneBarButtonTapped(_ sender: Any) {
        guard let list = list,
              let name = itemNameTextFiled.text, !name.isEmpty,
              let quantity = quantityTextField.text, !quantity.isEmpty else {return}
        ShoppingListController.shared.updateShoppingList(list: list, itemName: name, itemQuantity: Int(quantity) ?? 1)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func havePurchasedButtonTapped(_ sender: Any) {
        guard let listToToggle = list else {return}
        ShoppingListController.shared.toggleHasPurchased(list: listToToggle)
        updateBottonCheckList(listToToggle)
    }
    
    // MARK: - Helper Fuctions
    func updateBottonCheckList(_ list: ShoppingList) {
        let imageButtonText = list.havePurchased ? "complete" : "incomplete"
        let imageButtonShow = UIImage(named: imageButtonText)
        havePurchasedButton.setImage(imageButtonShow, for: .normal)
    }
    
    func updateView() {
        guard let list = list else {return}
        itemNameTextFiled.text = list.itemName
        quantityTextField.text = String(list.itemQuantity)
        updateBottonCheckList(list)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

