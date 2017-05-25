//
//  ItemState.swift
//  BucketList
//
//  Created by Thomas on 5/22/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import Foundation

struct NewItemState {
	var category: Int?
	var newItem = Item()
	var images: [String]?
	var locations: [Any]?
}
