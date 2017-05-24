//
//  ViewController.swift
//  BucketList
//
//  Created by Thomas on 1/3/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class ViewController: UIViewController, StoreSubscriber, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!
	
//	var theStore = store
	
	var categories = [Category]()
	var imgs = [UIImage]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.automaticallyAdjustsScrollViewInsets = false
		self.tableView.tableFooterView = UIView(frame: .zero)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		store.subscribe(self) { state in
			state.categoriesState
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		
		store.unsubscribe(self)
	}
	
	func newState(state: CategoriesState) {
		categories = state.categories
		tableView.reloadData()
	}
	
	// MARK: Table view data source
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categories.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
		
		let c = categories[indexPath.row]
		cell.textLabel?.text = c.name

		return cell
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			store.dispatch(RemoveCategory(routeSpecificData: categories[indexPath.row]))
		}
	}
	
	// MARK: Navigation
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedCategory = categories[indexPath.row]
		let route = [categoriesViewRoute, listItemsViewRoute]
		let setRoute = ReSwiftRouter.SetRouteAction(route)
		let data = ReSwiftRouter.SetRouteSpecificData(route: route, data: selectedCategory)
		
		store.dispatch(SelectCategory(routeSpecificData: selectedCategory))
		store.dispatch(data)
		store.dispatch(setRoute)
	}
	
	@IBAction func addCategory(_ sender: Any) {
		store.dispatch(ReSwiftRouter.SetRouteAction([categoriesViewRoute, addCategoryViewRoute]))
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
		
	}
}

