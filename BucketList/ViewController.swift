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
	
	var imgs = [UIImage]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.automaticallyAdjustsScrollViewInsets = false
		self.tableView.tableFooterView = UIView(frame: .zero)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		store.subscribe(self) { state in
			state.categories
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		
		store.unsubscribe(self)
	}
	
	func newState(state: [Category]?) {
		tableView.reloadData()
	}
	
	// MARK: Table view data source
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return store.state.categories!.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
		
		let c = store.state.categories?[indexPath.row]
		cell.textLabel?.text = c?.name

		return cell
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			//store.dispatch(RemoveCategory(routeSpecificData: categories[indexPath.row]))
		}
	}
	
	// MARK: Navigation
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedCategory = store.state.categories?[indexPath.row]
		store.dispatch(SelectCategory(category: selectedCategory))
		
		let route = [categoriesViewRoute, listItemsViewRoute]
		let setRoute = ReSwiftRouter.SetRouteAction(route)
		
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

