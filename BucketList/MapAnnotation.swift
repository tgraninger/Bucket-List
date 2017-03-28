//
//  MapAnnotation.swift
//  BucketList
//
//  Created by Thomas on 2/15/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import UIKit
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
	var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
	var title: String?
	
	init(coordinate: CLLocationCoordinate2D, title: String) {
		self.coordinate = coordinate
		self.title = title
	}
}
