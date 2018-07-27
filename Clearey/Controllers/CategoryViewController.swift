//
//  CategoryViewController.swift
//  Clearey
//
//  Created by Zeo on 2018. 06. 28..
//  Copyright © 2018. Zeo. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

	var categories = [Categs]()
	
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

	
    override func viewDidLoad() {
        super.viewDidLoad()

		loadCategories()
		
	}

	//MARK: - TableView Datasource Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return categories.count
		
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryItemCell", for: indexPath)
		
		cell.textLabel?.text = categories[indexPath.row].name
		
		return cell
	}
	
	//MARK:- TableView Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		performSegue(withIdentifier: "goToItems", sender: self)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destinationVC = segue.destination as! TodoViewController
		
		if let indexPath = tableView.indexPathForSelectedRow {
			destinationVC.selectedCategory = categories[indexPath.row]
	}
	}
	
	//MARK: - Data Manipulation Methods

	func saveCategories () {
		
		do {
			
			try context.save()
		} catch {
			
			print("Error saving context, \(error)")
		}
		
		self.tableView.reloadData()
		
		
	}
	
	func loadCategories(with request: NSFetchRequest<Categs> = Categs.fetchRequest()) {
		
		do {
			
			categories = try context.fetch(request)
			
		} catch {
			
			print("Error fetching data from context \(error)")
			
		}
		
		tableView.reloadData()
		
	}

	//MARK: - Add New Categories
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		
		var TextField = UITextField()
		
		let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
			
			let newCategory = Categs(context: self.context)
			newCategory.name = TextField.text!
			
			self.categories.append(newCategory)
			
			self.saveCategories()
			
		}
		
		alert.addTextField { (alertTextField) in
			
			alertTextField.placeholder = "Hope to god this works"
			TextField = alertTextField
			
		}
		
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)

	}
	
	
	}


