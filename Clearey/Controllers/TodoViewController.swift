//
//  ViewController.swift
//  Clearey
//
//  Created by Zeo on 2018. 03. 23..
//  Copyright © 2018. Zeo. All rights reserved.
//

import UIKit
import CoreData

class TodoViewController: UITableViewController {
	
	var itemArray = [Item]()
	
	var selectedCategory : Categs? {
		didSet{
			loadItems()
		}
	}
	
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	override func viewDidLoad() {
		super.viewDidLoad()

	}
	
	//MARK: - TableView Datasource Method
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	
		return itemArray.count
	
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
		
		let item = itemArray[indexPath.row]
		
		cell.textLabel?.text = item.title

		return cell
	}
	
	//MARK: - TableView Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		
		itemArray[indexPath.row].done = !itemArray[indexPath.row].done
		
		saveItems()

		tableView.deselectRow(at: indexPath, animated: true)
	
	}
	
	//MARK:  - Add New Items
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		
		var TextField = UITextField()
		
		let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			
			let newItem = Item(context: self.context)
			newItem.title = TextField.text!
			newItem.done = false
			
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
		
		do {
			
			try context.save()
		} catch {
			
			print("Error saving context, \(error)")
		}

		self.tableView.reloadData()

		
	}
	
	func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
		
		do {
		
			itemArray = try context.fetch(request)
			
		} catch {
			
			print("Error fetching data from context \(error)")
		
		}
		
		tableView.reloadData()
		
	}
	
	
}

//MARK: - Search Bar Methods

extension TodoViewController: UISearchBarDelegate {

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		
		let request : NSFetchRequest<Item> = Item.fetchRequest()
		
		request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
		
		request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
		
		loadItems(with: request)
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

		if searchBar.text?.count == 0 {
			loadItems()

			DispatchQueue.main.async {
				searchBar.resignFirstResponder()
			}

		}
	}

}


