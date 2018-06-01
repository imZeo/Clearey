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
	
	let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

	override func viewDidLoad() {
		super.viewDidLoad()
		
		print(dataFilePath!)

		loadItems()
		 
//		if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//			itemArray = items
//		}


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
		
		saveItems()

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
			
			self.saveItems()
			
		}
		
		alert.addTextField { (alertTextField) in
			
			alertTextField.placeholder = "Be creative, achieve everything!"
			TextField = alertTextField
		
		}
		
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
	}
	
	func saveItems () {
		
		let encoder = PropertyListEncoder()
		
		do {
			
			let data = try encoder.encode(itemArray)
			try data.write(to: dataFilePath!)
			
		} catch {
			
			print("Error encoding item array, \(error)")
			
		}

		tableView.reloadData()

		
	}
	
	func loadItems() {
		
		if let data = try? Data(contentsOf: dataFilePath!) {
			
			let decoder = PropertyListDecoder()
			do {
				
				itemArray = try decoder.decode([Item].self, from: data)
			
			} catch {
			
				print("Error decoding array, \(error)")
			
			}
	}
	

}

}

