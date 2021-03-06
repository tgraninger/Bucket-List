//
//  ItemsReducer.swift
//  BucketList
//
//  Created by Thomas on 5/21/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import ReSwift
import RealmSwift

func categoryReducer(state: Category?, action: Action) -> Category? {
	var state = state
	
	switch action {
	case let action as RemoveItem:
//		let index = state?.index(of: action.index)
//		removeItem(index!, from: action.category)
//		state.remove(at: index!)
		break
	case let action as SelectCategory:
		state = action.category
		break
	default:
		break
	}
	return state
}

func removeItem(_ index: Int, from category: Category) {
	let realm = try! Realm()
	try! realm.write {
		category.items.remove(at: index)
	}
}
