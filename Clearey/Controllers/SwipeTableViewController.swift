//
//  SwipeTableViewController.swift
//  
//
//  Created by Zeo on 29/09/2018.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

		tableView.rowHeight = 80.0
    }
	
	//TableView Datasource Methods
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell

		cell.delegate = self
		
		return cell
	}


	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
		guard orientation == .right else { return nil }
		
		let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in

			self.updateModel(at: indexPath)
			
			print("delete cell")
			
		}
		
		// customize the action appearance
		deleteAction.image = UIImage(named: "Trash-Icon")
		
		return [deleteAction]
	}
	
	func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
		var options = SwipeOptions()
		options.expansionStyle = .destructive
		return options
	}
	
	func updateModel(at indexPath: IndexPath) {
		//update model
	}

}
