//
//  Extensions.swift
//  BucketList
//
//  Created by Thomas on 5/18/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import UIKit
import Foundation

// MARK - UINavigationController

extension UINavigationController {
	
	func pushViewController(_ viewController: UIViewController,
	                        animated: Bool, completion: @escaping (Void) -> Void) {
		
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		pushViewController(viewController, animated: animated)
		CATransaction.commit()
	}
	
	func popViewController(_ animated: Bool, completion: @escaping (Void) -> Void) {
		
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		self.popViewController(animated: animated)
		CATransaction.commit()
	}
	
}

// MARK - UIImageView

extension UIImageView {
	public func imageFromUrl(urlString: String) {
		URLSession.shared.dataTask(with: URL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
			if error != nil {
				print(error?.localizedDescription)
				return
			}
			DispatchQueue.main.async(execute: { () -> Void in
				let image = UIImage(data: data!)
				self.image = image
			})
			
		}).resume()
	}
}
