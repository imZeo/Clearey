//
//  Category.swift
//  Clearey
//
//  Created by Zeo on 11/09/2018.
//  Copyright © 2018 Zeo. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
	@objc dynamic var colour: String = ""
    
}

