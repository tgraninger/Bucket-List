//
//  ImageSearchClient.swift
//  BucketList
//
//  Created by Thomas on 5/19/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import Foundation
import ReSwift

class ImageSearchClient {
	
	func fetchImagesForItem(_ itemName: String, completion: @escaping ([String]?) -> ()) {
		
		let searchText: String! = itemName
		
		let urlPath = "https://pixabay.com/api/?key=5413279-0c9ea709391f91ed9ab8c1561&q=\(searchText)&image_type=photo".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
		
		let url = URL(string: urlPath!)
		
		var request = URLRequest(url: url!)
		request.httpMethod = "GET"
		
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			
			guard let responseData: Data = data, error == nil
				else { return }
			
			guard let json = try? JSONSerialization.jsonObject(with: responseData, options: []) as! [String : AnyObject]
				else { return }
					
			let hits = json["hits"] as! [AnyObject]
			
			var images = [String]()
			
			for item in hits {
				//let item = item as! [String : AnyObject]
				images.append(item["webformatURL"] as! String)
			}
			
			DispatchQueue.main.async {
				completion(images)
			}
		}
		task.resume()		
	}

}
