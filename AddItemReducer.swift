//
//  ItemReducer.swift
//  BucketList
//
//  Created by Thomas on 5/19/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import ReSwift
import RealmSwift

func newItemReducer(state: NewItemState?, action: Action) -> NewItemState {
	var state = state ?? NewItemState()
	
	switch action {
	case let action as AddItem:
		addItem(action.item, to: action.category)
	case let action as SearchMaps:
		let locationSearchClient = LocationSearchClient()
		locationSearchClient.searchForText(text: action.routeSpecificData!.name)
		break
	case let action as SearchImages:
		return setImages(state, imageSearchResults: action.images)
	case let action as SetImage:
		return userSelectedImage(state, selectedImage: action.routeSpecificData)
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

func setImages(_ state: NewItemState, imageSearchResults: [String]?) -> NewItemState {
	var state = state
	
	state.images = imageSearchResults
	
	return state
}

func userSelectedImage(_ state: NewItemState, selectedImage: String) -> NewItemState {
	var state = state
	
	state.newItem.img = selectedImage
	
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






