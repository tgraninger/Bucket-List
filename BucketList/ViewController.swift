//
//  ViewController.swift
//  BucketList
//
//  Created by Thomas on 1/3/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
	@IBOutlet weak var title: UILabel!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var backgroundImage: UIImageView!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var imageFilterView: UIView!
	
	let dh = DataHandler.sharedInstance
	var categories = [CategoryMO]()
	var imgs = [UIImage]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		DispatchQueue.main.async {
			// Lets do this on the main thread...
			self.imgs = self.dh.selectRandomImages()
			self.backgroundImage.image = self.imgs[0]
		}
		
		self.dh.getCategories()
		self.tableView.backgroundColor = UIColor.clear
		self.tableView.tableFooterView = UIView(frame: .zero)
		self.tableView.reloadData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		self.categories = dh.categories
		self.tableView.reloadData()
	}
	
	// MARK: Table view data source
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categories.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
		let c = categories[indexPath.row]
		cell.title?.text = c.categoryName
		cell.title?.textColor = UIColor.white
		cell.backgroundColor = UIColor.clear
		cell.selectionStyle = .none
		return cell
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			categories.remove(at: indexPath.row)
//			self.dh.deleteCat
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	
	// MARK: Navigation
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "showAdventures", sender: self)
	}
	
	@IBAction func addCategory(_ sender: Any) {
		self.performSegue(withIdentifier: "addCategory", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showAdventures" {
			if let indexPath = tableView.indexPathForSelectedRow {
				let vc = segue.destination as! AdventureViewController
				vc.imgs = [self.imgs[2], self.imgs[3]]
				vc.category = categories[indexPath.row]
			}
		} else if segue.identifier == "addCategory" {
			let vc = segue.destination as! AddCategoryViewController
			vc.img = imgs[1]
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
		
	}
}

