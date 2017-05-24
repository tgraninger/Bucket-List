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
		case let action as AddItem:
			addItem(action.item, to: action.category)
		case let action as SearchMaps:
			//		let locationSearchClient = LocationSearchClient()
			//		locationSearchClient.searchForText(text: action.routeSpecificData!.name)
			break
		case let action as SearchImages:
			setImages(state)
		case let action as SetImage:
			return userSelectedImage(state, selectedImage: action.selectedImage)
		case let action as SearchMaps:
			//state.location = action.routeSpecificData!
			break
		case let action as SetLocation:
			break
		default:
			break
		}
		return state
	}
	
	func addItem(_ item: Item, to category: Category) {
		let realm = try! Realm()
		try! realm.write {
			category.items.append(item)
		}
	}
	
	func setImages(_ state: NewItemState) {
		var state = state
		
		ImageSearchClient().fetchImagesForItem(state.newItem.name) { (data) in
			state.images = data
		}
	}
	
	func userSelectedImage(_ state: NewItemState, selectedImage: String) -> NewItemState {
		var state = state
		
		state.newItem.img = selectedImage
		state.images = nil
		
		return state
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








