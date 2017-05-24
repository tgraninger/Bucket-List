//
//  AddImageViewController.swift
//  BucketList
//
//  Created by Thomas on 5/19/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class AddImageViewController: UIViewController, StoreSubscriber, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	@IBOutlet weak var collectionView: UICollectionView!
	
	var item: Item!
	var dataStore: [String]?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.automaticallyAdjustsScrollViewInsets = false
    }
	
	override func viewWillAppear(_ animated: Bool) {
		store.subscribe(self) { state in
			let item: Item! = state.navigationState.getRouteSpecificState(state.navigationState.route)
			return item
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		store.unsubscribe(self)
		
		if store.state.navigationState.route == [categoriesViewRoute, listItemsViewRoute, addItemViewRoute, addImageViewRoute] {
			store.dispatch(SetRouteAction([categoriesViewRoute, listItemsViewRoute, addItemViewRoute]))
		}
	}
	
	func newState(state: Item) {
		//store.dispatch(fetchImagesForItem(item.name))

		//item = state.item
		//dataStore = state.images
		collectionView.reloadData()
	}
	
	// MARK - Collection View Data Source
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataStore != nil ? dataStore!.count : 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
		
		let item = dataStore?[indexPath.row]
		cell.imageView.imageFromUrl(urlString: item!)
		cell.imageView.contentMode = .scaleAspectFill
		
		return cell
	}
	
	// MARK - Collection View Delegate
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		store.dispatch(SetImage(item: item, routeSpecificData: dataStore?[indexPath.row]))
		
		let route = [categoriesViewRoute, listItemsViewRoute, addItemViewRoute]
		store.dispatch(ReSwiftRouter.SetRouteAction(route))
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: (collectionView.bounds.width - 20) / 2, height: collectionView.bounds.height / 6)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}