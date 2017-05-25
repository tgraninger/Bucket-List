//
//  Helper.swift
//  BucketList
//
//  Created by Thomas on 5/25/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import Foundation
import RealmSwift

func incrementID() -> Int {
	let realm = try! Realm()
	return (realm.objects(Category.self).max(ofProperty: "id") as Int? ?? 0) + 1
}
