//
//  Actions.swift
//  BucketList
//
//  Created by Thomas on 5/18/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import ReSwift


// MARK - Categories

struct AddCategory: Action {
	let routeSpecificData: Category!
}

struct RemoveCategory: Action {
	let routeSpecificData: Category!
}

struct SelectCategory: Action {
	let routeSpecificData: Category!
}

// MARK - Items

struct SetItems: Action {
	let routeSpecificData: Category!
}

struct RemoveItem: Action {
	let category: Category!
	let item: Item!
}

// MARK - Items (Adding)

struct AddItem: Action {
	let category: Category!
	let item: Item!
}

struct SearchImages: Action {
	let images: [String]?
}

struct SetImage: Action {
	let item: Item!
	let routeSpecificData: String!
}

struct SearchMaps: Action {
	let routeSpecificData: Item!
}

struct SetLocation: Action {
	let routeSpecificData: MapAnnotation!
}


