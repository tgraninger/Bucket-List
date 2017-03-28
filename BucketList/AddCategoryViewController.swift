//
//  AddCategoryViewController.swift
//  BucketList
//
//  Created by Thomas on 2/6/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var bgimg: UIImageView!
	@IBOutlet weak var tf: UITextField!
	
	var img: UIImage!
		
    override func viewDidLoad() {
        super.viewDidLoad()
		self.bgimg.image = img
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
	}
	
	@IBAction func buttonTapped(_ sender: Any) {
		if tf.text != nil {
			let dh = DataHandler.sharedInstance
			dh.storeCategory(name: tf.text!)
			_ = self.navigationController?.popViewController(animated: true)
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
