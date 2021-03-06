//
//  AddAdventureViewController.swift
//  BucketList
//
//  Created by Thomas on 2/6/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class AddItemViewController: UIViewController, StoreSubscriber, UITextFieldDelegate {

	@IBOutlet weak var tfBackgroundView: UIView!
	@IBOutlet weak var tf: UITextField!
	@IBOutlet weak var bgimg: UIImageView!
	
	//	Create outlet for add adventure button to change title to edit if adventure exists
	
	var img: UIImage!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		store.subscribe(self) { state in
			state.newItemState
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)

		store.unsubscribe(self)
		
		if store.state.navigationState.route == [categoriesViewRoute, listItemsViewRoute, addItemViewRoute] {
			store.dispatch(SetRouteAction([categoriesViewRoute, listItemsViewRoute]))
		}
	}
	
	func newState(state: NewItemState) { }
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
	}
	
	func textFieldDidChange(_ textField: UITextField) {
		store.dispatch(SetItemName(name: textField.text))
	}
	
	@IBAction func buttonTapped(_ sender: Any) {
		if store.state.newItemState.newItem.name != nil {
			store.dispatch(AddItem(item: store.state.newItemState.newItem))
			
			let route = ReSwiftRouter.SetRouteAction([categoriesViewRoute, listItemsViewRoute])
			
			store.dispatch(route)
		}
	}
	
	@IBAction func addPhotoButtonTapped(_ sender: Any) {
		let route = store.state.navigationState.route + [addImageViewRoute]
		let routeAction = ReSwiftRouter.SetRouteAction(route)
		
		store.dispatch(routeAction)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
