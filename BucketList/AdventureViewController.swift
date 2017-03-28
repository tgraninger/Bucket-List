//
//  AdventureViewController.swift
//  BucketList
//
//  Created by Thomas on 2/6/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import UIKit

class AdventureCell: UITableViewCell {
	@IBOutlet weak var label: UILabel!
}

class AdventureViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var tv: UITableView!
	@IBOutlet weak var bgimg: UIImageView!
	@IBOutlet weak var imageFilterView: UIView!
	
	var category: CategoryMO!
	var adventures = [AdventureMO]()
	var imgs = [UIImage]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		DispatchQueue.main.async {
			// Lets do this on the main thread...
			self.bgimg.image = self.imgs[0]
		}
		
		self.navigationItem.title = category.categoryName
		self.tv.backgroundColor = UIColor.clear
		self.tv.tableFooterView = UIView(frame: .zero)
		self.tv.contentInset = UIEdgeInsetsMake(12, 0, 0, 0)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		adventures = category.adventures?.allObjects as! [AdventureMO]
		self.tv.reloadData()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		if isMovingFromParentViewController {
			self.imageFilterView.removeFromSuperview()
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return adventures.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tv.dequeueReusableCell(withIdentifier: "AdventureCell", for: indexPath) as! AdventureCell
		let a = adventures[indexPath.row]
		cell.label?.text = a.adventureName
		cell.label?.textColor = UIColor.white
		cell.backgroundColor = UIColor.clear
		cell.selectionStyle = .none
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "addAdventure", sender: self)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let vc = segue.destination as! AddAdventureViewController
		vc.category = category
		vc.img = self.imgs[1]
		
		if (sender is UIBarButtonItem) == false {
			let indexPath = self.tv.indexPathForSelectedRow
			vc.adventure = self.adventures[(indexPath?.row)!]
		}
    }
}
