//
//  ItemReducer.swift
//  BucketList
//
//  Created by Thomas on 5/19/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import ReSwift
import RealmSwift

struct NewItemReducer: Reducer {
	
	func handleAction(action: Action, state: NewItemState?) -> NewItemState {
		var state = state ?? NewItemState()
		
		switch action {
		case let action as SelectCategory:
			state.category = action.routeSpecificData
		case let action as AddItem:
			addItem(state)
		case _ as SearchImages:
			ImageSearchClient().fetchImagesForItem(state.newItem.name)
		case let action as SetImages:
			state.images = action.images
		case let action as SetImage:
			state.newItem.img = action.selectedImage
			state.images = nil
		case _ as SearchMaps:
		//		let locationSearchClient = LocationSearchClient()
		//		locationSearchClient.searchForText(text: action.routeSpecificData!.name)
			break
		case let action as SetLocation:
			break
		default:
			break
		}
		return state
	}
	
	func addItem(_ state: NewItemState) {
		//var state = state
		
		let category = state.category
		
		let realm = try! Realm()
		
		try! category.realm?.write {
			realm.add(state.newItem)
		}
		
		
	}
	
	func setLocations(_ state: NewItemState, locationSearchResults: [Any]?) -> NewItemState {
		var state = state
		
		state.locations = locationSearchResults
		
		return state
	}
	
	func userSelectedLocation(_ state: NewItemState, selectedLocation: Any) -> NewItemState {
		var state = state
		
		//state.newItemState.newItem.latitude
		//state.newItemState.newItem.longitude
		
		return state
	}
	
	func fetchLocationForItem(_  item: Item) {
		//let itemLocations = ItemLocation()
		
	}
}

//func newItemReducer(state: NewItemState?, action: Action) -> NewItemState {
//
//}








