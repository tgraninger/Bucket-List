//
//  AppReducer.swift
//  BucketList
//
//  Created by Thomas on 5/23/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftRouter

struct AppReducer: Reducer {
	
	func handleAction(action: Action, state: AppState?) -> AppState {
		return AppState(navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
		                categoriesState: CategoryReducer().handleAction(action: action, state: state?.categoriesState),
		                category: itemsReducer(state: state?.items, action: action),
		                newItemState: NewItemReducer().handleAction(action: action, state: state?.newItemState)
		)
	}
}
