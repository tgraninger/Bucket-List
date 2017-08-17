//
//  CategoriesReducer.swift
//  BucketList
//
//  Created by Thomas on 5/18/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import ReSwift
import ReSwiftRouter
import RealmSwift


struct CategoryReducer: Reducer {
	
	func handleAction(action: Action, state: [Category]?) -> [Category] {
		var state = state ?? fetchCategories()
		
		switch action {
		case let action as AddCategory:
			try! Realm().addCategory(name: action.name)
			
			state = fetchCategories()
		case let action as RemoveCategory:
			break
		default:
			break
		}
		return state
	}
	
	func fetchCategories() -> [Category] {
		let realm = try! Realm()
		let categories = realm.categories
		
		if categories.count == 0 {
			let names = ["Venues", "Restaurants", "Travels", "Films"]
			for n in names {
				realm.addCategory(name: n)
			}
		}
		return Array(categories)
	}
}





