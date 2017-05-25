//
//  AppState.swift
//  BucketList
//
//  Created by Thomas on 5/18/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import ReSwift
import ReSwiftRouter

struct AppState: StateType, HasNavigationState {
	var navigationState: NavigationState
	var categories: [Category]?
	var category: Category?
	var newItemState: NewItemState
}
