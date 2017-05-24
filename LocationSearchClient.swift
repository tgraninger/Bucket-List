//
//  ItemLocationReducer.swift
//  BucketList
//
//  Created by Thomas on 5/19/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class LocationSearchClient: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
	
	var locationManager: CLLocationManager!
	var location: CLLocation?
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if CLLocationManager.locationServicesEnabled() {
			switch CLLocationManager.authorizationStatus() {
			case .notDetermined, .restricted, .denied:
				locationManager.requestWhenInUseAuthorization()
			default:
				break
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if locations.first != nil {
			locationManager.stopUpdatingLocation()
			self.location = locations.first
		}
	}
	
	func searchForText(text: String) {

		let request = MKLocalSearchRequest()
		request.naturalLanguageQuery = text
		
		let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
		request.region = MKCoordinateRegionMake(self.location!.coordinate, span)
		
		var responseItems: [MKMapItem]!
		
		let search = MKLocalSearch(request: request)
		search.start { (response, error) in
			for mapItem in (response?.mapItems)! as [MKMapItem] {
				print("Item name: \(mapItem.name)")
				responseItems.append(mapItem)
			}
		}
	}
/*
	func addPinToMapView(title: String, lat: CLLocationDegrees, long: CLLocationDegrees) {
		let loc = CLLocationCoordinate2D(latitude: lat, longitude: long)
		let annotation = MapAnnotation.init(coordinate: loc, title: title)
		//mapView.addAnnotation(annotation)
	}
*/
	
/*
	func zoomToLocation(location: CLLocation) {
		let spanX = 0.1
		let spanY = 0.1
		var region = MKCoordinateRegion()
		region.center.latitude = location.coordinate.latitude
		region.center.longitude = location.coordinate.longitude
		region.span = MKCoordinateSpanMake(spanX, spanY)
		mapView.setRegion(region, animated: true)
	}
*/
}
