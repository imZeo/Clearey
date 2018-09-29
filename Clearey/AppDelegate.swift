//
//  AppDelegate.swift
//  Clearey
//
//  Created by Zeo on 2018. 03. 23..
//  Copyright © 2018. Zeo. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		do {
			_ = try Realm()
		} catch {
			print("Error init new realm, \(error)")
		}
		
        return true
	}

	
	// MARK: - Core Data stack
	
	}


