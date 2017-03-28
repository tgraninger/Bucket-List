//
//  AddAdventureViewController.swift
//  BucketList
//
//  Created by Thomas on 2/6/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import UIKit

class AddAdventureViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var tfBackgroundView: UIView!
	@IBOutlet weak var tf: UITextField!
	@IBOutlet weak var bgimg: UIImageView!
	@IBOutlet weak var locationButton: UIButton!
	@IBOutlet weak var photoButton: UIButton!
	@IBOutlet weak var buttonsView: UIView!
	@IBOutlet weak var buttonsViewTopMargin: NSLayoutConstraint!
	
	//	Create outlet for add adventure button to change title to edit if adventure exists
	
	let dh = DataHandler.sharedInstance
	var category: CategoryMO!
	var adventure: AdventureMO!
	var img: UIImage!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tf.backgroundColor = UIColor.clear
		self.bgimg.image = img
		//self.setupSubviews()
		
		if adventure != nil {
			
			self.saveButtonPressed()	//	Should add edit button as right bar button item.
			
			if adventure.address == nil {
				locationButton.setTitle("Show in maps", for: .normal)
			} else {
				locationButton.setTitle("Add location", for: .normal)
			}
			
			if adventure.adventureImage != nil {
				img = UIImage.init(named: adventure.adventureImage!)
			}
		} else {
			self.navigationController?.navigationItem.rightBarButtonItem = nil
		}
    }
	
	func setupSubviews() {
		if adventure != nil {
			
			self.saveButtonPressed()	//	Should add edit button as right bar button item.
			
			if adventure.address == nil {
				locationButton.setTitle("Show in maps", for: .normal)
			} else {
				locationButton.setTitle("Add location", for: .normal)
			}
			
			if adventure.adventureImage != nil {
				img = UIImage.init(named: adventure.adventureImage!)
			}
		} else {
			self.navigationController?.navigationItem.rightBarButtonItem = nil
		}
	}
	
	func editButtonPressed() {
		self.tf.isHidden = false
		self.tfBackgroundView.isHidden = false
		
		UIView.animate(withDuration: 0.5, animations: {
			self.buttonsViewTopMargin.constant = 95
			self.view.updateConstraints()
			self.view.layoutIfNeeded()
		})

		self.navigationController?.navigationItem.rightBarButtonItem = nil
		let save = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
		self.navigationController?.navigationItem.rightBarButtonItem = save
	}
	
	func saveButtonPressed() {
		self.tf.isHidden = true
		self.tfBackgroundView.isHidden = true

		UIView.animate(withDuration: 0.5, animations: {
			self.buttonsViewTopMargin.constant = 40
			self.view.updateConstraints()
			self.view.layoutIfNeeded()
		})
		
		let edit = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(editButtonPressed))
		self.navigationController?.navigationItem.rightBarButtonItem = edit
		self.navigationController?.navigationItem.title = adventure.adventureName
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		textField.text = ""
	}
	
	@IBAction func buttonTapped(_ sender: Any) {
		if tf.text != nil {
			dh.storeAdventure(category: category, name: tf.text!)
		}
		_ = self.navigationController?.popViewController(animated: true)
	}
	
	@IBAction func addPhotoButtonTapped(_ sender: Any) {
		//	Push alert view for access to photos
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showMap" {
			let vc = segue.destination as! MapViewController
			//	Pass textField data to vc
			if self.adventure == nil {
				if self.tf.text != "" {
					vc.searchText = self.tf.text
				}
			} else {
				vc.adventure = self.adventure
			}
		}
    }
}
