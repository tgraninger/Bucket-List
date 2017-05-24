//
//  Models.swift
//  BucketList
//
//  Created by Thomas on 5/18/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift


class Category: Object {
	dynamic var name = ""
	dynamic var img: String? = nil
	var items = List<Item>()
}

class Item: Object {
	dynamic var name = ""
	dynamic var img: String? = nil
	dynamic var latitude: String?
	dynamic var longitude: String?
}
