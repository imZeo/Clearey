//
//  ViewController.swift
//  Clearey
//
//  Created by Zeo on 2018. 03. 23..
//  Copyright © 2018. Zeo. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
	
	var itemArray = [Item]()
	
	let defaults = UserDefaults.standard

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let newItem1 = Item()
		newItem.Title = "Find Ring"
		itemArray.append(newItem)

		let newItem2 = Item()
		newItem.Title = "Call Saruman"
		itemArray.append(newItem)

		let newItem3 = Item()
		newItem.Title = "Have secret meeting"
		itemArray.append(newItem)

		 
		if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
			itemArray = items
		}


	}
	
	//MARK - TableView Datasource Method
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	
		return itemArray.count
	
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
		
		let item = itemArray[indexPath.row]
		
		cell.textLabel?.text = item.title
		
		cell.accessoryType = item.done ? .checkmark : .none
		
		return cell
	}
	
	//MARK - TableView Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		//print(itemArray[indexPath.row])
		
		itemArray[indexPath.row].done = !itemArray[indexPath.row].done
		
		tableView.reloadData()
		
		tableView.deselectRow(at: indexPath, animated: true)
	
	}
	
	//MARK  - Add New Items
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		
		var TextField = UITextField()
		
		let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			
			let newItem = Item()
			newItem.title = TextField.text!
			
			self.itemArray.append(newItem)
			
			self.defaults.set(self.itemArray, forKey: "TodoListArray")
			
			self.tableView.reloadData()
		
		}
		
		alert.addTextField { (alertTextField) in
			
			alertTextField.placeholder = "Be creative, achieve everything!"
			TextField = alertTextField
		
		}
		
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
	}
	

}
