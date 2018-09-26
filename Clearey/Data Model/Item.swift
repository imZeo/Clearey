//
//  Item.swift
//  Clearey
//
//  Created by Zeo on 11/09/2018.
//  Copyright © 2018 Zeo. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}