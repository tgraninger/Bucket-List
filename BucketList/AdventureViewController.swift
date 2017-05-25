//
//  AdventureViewController.swift
//  BucketList
//
//  Created by Thomas on 2/6/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class ItemCell: UICollectionViewCell {
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var itemNameLabel: UILabel!
}

class ItemViewController: UIViewController, StoreSubscriber, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	@IBOutlet weak var collectionView: UICollectionView!
	
	var imgs = [UIImage]()
	var items: [Item]?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let addButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addItem(_ :)))
		self.navigationItem.rightBarButtonItem = addButton
		self.automaticallyAdjustsScrollViewInsets = false
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		store.subscribe(self) { state in
			state.category
		}
		
		self.navigationItem.title = store.state.category?.name
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		
		store.unsubscribe(self)
		
		if store.state.navigationState.route == [categoriesViewRoute, listItemsViewRoute] {
			store.dispatch(SetRouteAction([categoriesViewRoute]))
		}
	}
	
	func newState(state: Category?) {
		items = Array((state?.items)!)
		
		collectionView.reloadData()
	}
	
	// MARK - Collection View Data Source
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items != nil ? items!.count : 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
		let item: Item! = items?[indexPath.row]
		
		cell.itemNameLabel?.text = item.name
		cell.imageView?.image = UIImage(named: "placeholder")
		
		if item.img != nil {
			cell.imageView?.imageFromUrl(urlString: (item.img)!)
		}
		
		return cell
	}
	
	// MARK - Collection View Delegate
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		// Push Map View...
	}
	
	// MARK - Collection View Flow Layout
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: (collectionView.bounds.width - 20) / 2, height: collectionView.bounds.height / 6)
	}
	
	// MARK - Actions

	func delete() {
		//if editingStyle == .delete {
		//let itemToDelete = items?[indexPath.row]
		//store.dispatch(RemoveItem(category: category, item: itemToDelete))
	}

	func addItem(_ sender: UIBarButtonItem) {
		store.dispatch(SetCategory(category: store.state.category?.id))
		
		let route = store.state.navigationState.route + [addItemViewRoute]
		let setRoute = ReSwiftRouter.SetRouteAction(route)
		
		store.dispatch(setRoute)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation
}
