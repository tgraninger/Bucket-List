//
//  DataHandler.swift
//  BucketList
//
//  Created by Thomas on 2/6/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataHandler {
	
	static let sharedInstance: DataHandler = DataHandler()
	
	var categories = [CategoryMO]()
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	func storeCategory(name: String) {
		let entity =  NSEntityDescription.entity(forEntityName: "CategoryMO", in: context)
		let category = NSManagedObject(entity: entity!, insertInto: context) as! CategoryMO
		category.categoryName = name
		categories.append(category)
		self.saveChanges()
	}
	
	func selectRandomImages() -> Array<UIImage> {
		let imgs = [#imageLiteral(resourceName: "bwc_1"), #imageLiteral(resourceName: "bwc_2"), #imageLiteral(resourceName: "gwada_1"), #imageLiteral(resourceName: "gwada_2"), #imageLiteral(resourceName: "gwada_3"), #imageLiteral(resourceName: "msp"), #imageLiteral(resourceName: "nyc_dark"), #imageLiteral(resourceName: "price_lake"), #imageLiteral(resourceName: "queens"), #imageLiteral(resourceName: "tsp"), #imageLiteral(resourceName: "wb_bridge"), #imageLiteral(resourceName: "wb_bridge_2")]
		let img1 = imgs[Int(arc4random_uniform(UInt32(imgs.count)))]
		let img2 = imgs[Int(arc4random_uniform(UInt32(imgs.count)))]
		let img3 = imgs[Int(arc4random_uniform(UInt32(imgs.count)))]
		let img4 = imgs[Int(arc4random_uniform(UInt32(imgs.count)))]
		return [img1, img2, img3, img4]
	}
	
	func getCategories() {
		let fetchRequest: NSFetchRequest<CategoryMO> = CategoryMO.fetchRequest()
		do {
			let searchResults = try context.fetch(fetchRequest)
			if searchResults.count == 0 {
				// Create some default categories...
				self.storeCategory(name: "Travels")
				self.storeCategory(name: "Venues")
				self.storeCategory(name: "Restaurants")
				self.storeCategory(name: "Films")
			} else {
				for category in searchResults as [CategoryMO] {
					if category.categoryName != nil {
						categories.append(category)
					} else {
						print("didn't have a title wtf y u in my context lol")
					}
				}
			}
		} catch {
			print("Error with request: \(error)")
		}
	}
	
	func deleteCategory(category: CategoryMO, index: Int) {
		self.categories.remove(at: index)
		self.context.delete(category)
		self.saveChanges()
	}
	
	func storeAdventure(category: CategoryMO, name: String) {
		let entity = NSEntityDescription.entity(forEntityName: "AdventureMO", in: context)
		let adventure = NSManagedObject(entity: entity!, insertInto: context) as! AdventureMO
		adventure.adventureName = name
		category.addToAdventures(adventure)
		self.saveChanges()
	}
	
	func saveChanges() {
		do {
			try context.save()
		} catch {
			print("Error with request: \(error)")
		}
	}
	
}

