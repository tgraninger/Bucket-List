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
	
	func handleAction(action: Action, state: CategoriesState?) -> CategoriesState {
		var state = state ?? fetchCategories()
		
		switch action {
		case let action as AddCategory:
			state = addCategory(state, category: action.routeSpecificData)
		case let action as RemoveCategory:
			state = removeCategory(state, category: action.routeSpecificData)
			break
		default:
			break
		}
		return state
	}
	
	func fetchCategories() -> CategoriesState {
		let realm = try! Realm()
		let categories = realm.objects(Category.self)
		
		if categories.count == 0 {
			let names = ["Venues", "Restaurants", "Travels", "Films"]
			for n in names {
				let c = Category()
				c.name = n
				try! realm.write {
					realm.add(c)
				}
			}
		}
		return CategoriesState(categories: Array(categories))
	}
	
	func addCategory(_ state: CategoriesState, category: Category) -> CategoriesState {
		var state = state
		let realm = try! Realm()
		try! realm.write {
			realm.add(category)
		}
		state.categories.append(category)
		
		return state
	}
	
	func removeCategory(_ state: CategoriesState, category: Category) -> CategoriesState {
		var state = state
		let realm = try! Realm()
		try! realm.write {
			realm.delete(category)
		}
		let index = state.categories.index(of: category)
		state.categories.remove(at: index!)
		
		return state
	}
}


//func categoriesReducer(state: CategoriesState?, action: Action) -> CategoriesState {
//	
//}




