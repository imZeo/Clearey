//
//  ViewController.swift
//  Clearey
//
//  Created by Zeo on 2018. 03. 23..
//  Copyright © 2018. Zeo. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoViewController: SwipeTableViewController {
	
	var todoItems: Results<Item>?
	let realm = try! Realm()
	
	@IBOutlet weak var searchBar: UISearchBar!
	
	
	var selectedCategory : Category? {
		didSet{
			loadItems()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.separatorStyle = .none
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		guard let colourHex = selectedCategory?.colour else {fatalError()}
		title = selectedCategory?.name
		
		updateNavBar(withHexCode: colourHex)

		
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		UIView.animate(withDuration: 1.0) {
			self.updateNavBar(withHexCode: "1D9BF6")
		}
	}
	
	//MARK: - Nav Bar Setup Methods
	
	func updateNavBar(withHexCode colourHexCode : String){
		guard let navBar = navigationController?.navigationBar else {fatalError("Navigation Controller does not exist.")}
		guard let navBarColour = UIColor(hexString: colourHexCode) else {fatalError()}
		
		
		navBar.barTintColor = navBarColour
		
		navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
		
		navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColour, returnFlat: true)]
		
		searchBar.barTintColor = navBarColour

	}
	
	//MARK: - TableView Datasource Method
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	
		return todoItems?.count ?? 1
	
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = super.tableView(tableView, cellForRowAt: indexPath)
		
//		let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
		
		if let item = todoItems?[indexPath.row] {

			cell.textLabel?.text = item.title
			
			if let colour = UIColor(hexString: selectedCategory!.colour)?.darken(byPercentage:
				CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {
				
				cell.backgroundColor = colour
				cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
			}
			cell.accessoryType = item.done ? .checkmark : .none
		
		} else {
			cell.textLabel?.text = "no items added"
		}
		

		return cell
	}
	
	//MARK: - TableView Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		if let item = todoItems?[indexPath.row] {
			do {
				try realm.write {
					item.done = !item.done
				}
			} catch {
				print("error saving done status, \(error)")
			}
		}
		
		tableView.reloadData()
		
		tableView.deselectRow(at: indexPath, animated: true)
	
	}
	
	//MARK:  - Add New Items
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			
			if let currentCategory = self.selectedCategory {
				do {
					try self.realm.write {
					
						let newItem = Item()
					
						newItem.title = textField.text!
						newItem.dateCreated = Date()
					
						currentCategory.items.append(newItem)
					}
				} catch {
					print("error saving new items \(error)")
				}
			
			}
			self.tableView.reloadData()
		}
		
		alert.addTextField { (alertTextField) in
			
			alertTextField.placeholder = "Be creative, achieve everything!"
			textField = alertTextField
		
		}
		
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
	}
	
	
	func loadItems() {
		
		todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

		tableView.reloadData()

	}
	
	//MARK: - Delete Items

	override func updateModel(at indexPath: IndexPath) {
		if let itemForDeletion = self.todoItems?[indexPath.row] {
			do {
				try self.realm.write {
					self.realm.delete(itemForDeletion)
				}
			} catch {
				print("error deleting category, \(error)")
			}
		}
	}
}


//MARK: - Search Bar Methods

extension TodoViewController: UISearchBarDelegate {

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		
		todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)

		tableView.reloadData()
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

