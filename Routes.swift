//
//  Routes.swift
//  BucketList
//
//  Created by Thomas on 5/18/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import UIKit
import ReSwiftRouter

let storyboard = UIStoryboard(name: "Main", bundle: nil)

let categoriesViewRoute: RouteElementIdentifier = "Categories"
let addCategoryViewRoute: RouteElementIdentifier = "AddCategory"
let listItemsViewRoute: RouteElementIdentifier = "BucketListItems"
let mapViewRoute: RouteElementIdentifier = "MapView"
let addItemViewRoute: RouteElementIdentifier = "AddItem"
let addImageViewRoute: RouteElementIdentifier = "AddImage"
let addLocationViewRoute: RouteElementIdentifier = "AddLocation"

let categoriesViewControllerIdentifier = "CategoriesViewController"
let addCategoryViewControllerIdentifier = "AddCategoryViewController"
let listItemsViewControllerIdentifier = "ListItemsViewController"
let mapViewControllerIdentifier = "MapViewController"
let addItemViewControllerIdentifier = "AddItemViewController"
let addImageViewControllerIdentifier = "AddImageViewController"
let addLocationViewControllerIdentifier = "AddLocationViewController"


class RootRoutable: Routable {
	
	let window: UIWindow
	
	init(window: UIWindow) {
		self.window = window
	}
	
	func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
		completionHandler()
		
		self.window.rootViewController = storyboard.instantiateViewController(withIdentifier: categoriesViewControllerIdentifier)
		return CategoriesViewRoutable(self.window.rootViewController!)
	}
	
	func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
		completionHandler()
	}
}

class CategoriesViewRoutable: Routable {
	
	let viewController: UIViewController
	
	init(_ viewController: UIViewController) {
		self.viewController = viewController
	}
	
	func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
		completionHandler()
		
		if routeElementIdentifier == addCategoryViewRoute {
			let addCategoryVC = storyboard.instantiateViewController(withIdentifier: addCategoryViewControllerIdentifier)
			(self.viewController as! UINavigationController).pushViewController(addCategoryVC, animated: true, completion: completionHandler)
			return AddCategoriesViewRoutable(self.viewController)
		}
		
		let itemsVC = storyboard.instantiateViewController(withIdentifier: listItemsViewControllerIdentifier)
		(self.viewController as! UINavigationController).pushViewController(itemsVC, animated: true, completion: completionHandler)
		return ItemsViewRoutable(self.viewController)
	}
	
	func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
		(self.viewController as! UINavigationController).popViewController(true, completion: completionHandler)
	}
}

class AddCategoriesViewRoutable: Routable {
	
	let viewController: UIViewController
	
	init(_ viewController: UIViewController) {
		self.viewController = viewController
	}
	
	func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
		(self.viewController as! UINavigationController).popViewController(true, completion: completionHandler)
	}
}

class ItemsViewRoutable: Routable {
	
	let viewController: UIViewController
	
	init(_ viewController: UIViewController) {
		self.viewController = viewController
	}
	
	func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
		completionHandler()
		
		if routeElementIdentifier == addItemViewRoute {
			let addItemVC = storyboard.instantiateViewController(withIdentifier: addItemViewControllerIdentifier)
			(self.viewController as! UINavigationController).pushViewController(addItemVC, animated: true, completion: completionHandler)
			return AddItemsViewRoutable(self.viewController)
		}
		
		let addLocationVC = storyboard.instantiateViewController(withIdentifier: mapViewControllerIdentifier)
		(self.viewController as! UINavigationController).pushViewController(addLocationVC, animated: true, completion: completionHandler)
		return MapRoutable()
	}
	
	func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
		if routeElementIdentifier == categoriesViewRoute {
			(self.viewController as! UINavigationController).popViewController(true, completion: completionHandler)
		}
		completionHandler()
	}
}

class ItemDetailsViewRoutable: Routable {
	let viewController: UIViewController
	
	init(_ viewController: UIViewController) {
		self.viewController = viewController
	}
	
	func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
		(self.viewController as! UINavigationController).popViewController(true, completion: completionHandler)
	}
}

class AddItemsViewRoutable: Routable {
	let viewController: UIViewController
	
	init(_ viewController: UIViewController) {
		self.viewController = viewController
	}
	
	func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
		
		if routeElementIdentifier == addImageViewRoute {
			let addImageVC = storyboard.instantiateViewController(withIdentifier: addImageViewControllerIdentifier)
			(self.viewController as! UINavigationController).pushViewController(addImageVC, animated: true, completion: completionHandler)
			return AddImageRoutable()
		}
		
		let addLocationVC = storyboard.instantiateViewController(withIdentifier: mapViewControllerIdentifier)
		(self.viewController as! UINavigationController).pushViewController(addLocationVC, animated: true, completion: completionHandler)
		return MapRoutable()
	}
	
	func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
		if routeElementIdentifier == listItemsViewRoute {
			(self.viewController as! UINavigationController).popViewController(true, completion: completionHandler)
		}
		completionHandler()
	}
}

class AddImageViewRoutable: Routable {
	let viewController: UIViewController
	
	init(_ viewController: UIViewController) {
		self.viewController = viewController
	}
	
	func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
		(self.viewController as! UINavigationController).popViewController(true, completion: completionHandler)
	}
}

class AddImageRoutable: Routable {}
class MapRoutable: Routable {}
