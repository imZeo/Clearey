//
//  ViewController.swift
//  Clearey
//
//  Created by Zeo on 2018. 03. 23..
//  Copyright © 2018. Zeo. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
	
	let itemArray = ["Find One Ring", "Warn Frodo", "Ride to Gondor"]

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	//MARK - TableView Datasource Method
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
		
		cell.textLabel?.text = itemArray[indexPath.row]
		
		return cell
	}
	
	//MARK - TableView Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		//print(itemArray[indexPath.row])
		
		if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
			tableView.cellForRow(at: indexPath)?.accessoryType = .none
		} else {
			tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
		}
		
		tableView.deselectRow(at: indexPath, animated: true)
	
	} 

}

