//
//  AddCategoryViewController.swift
//  BucketList
//
//  Created by Thomas on 2/6/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class AddCategoryViewController: UIViewController, StoreSubscriber, UITextFieldDelegate {

	@IBOutlet weak var bgimg: UIImageView!
	@IBOutlet weak var tf: UITextField!
	
	var img: UIImage!
		
    override func viewDidLoad() {
        super.viewDidLoad()
		self.bgimg.image = img
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		store.subscribe(self)
		
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		
		store.unsubscribe(self)
		
		if store.state.navigationState.route == [categoriesViewRoute, addCategoryViewRoute] {
			store.dispatch(SetRouteAction([categoriesViewRoute]))
		}
	}
	
	func newState(state: AppState) {}
	
	@IBAction func buttonTapped(_ sender: Any) {
		if tf.text != nil {
			store.dispatch(AddCategory(name: tf.text))
			
			store.dispatch(ReSwiftRouter.SetRouteAction([categoriesViewRoute]))
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
