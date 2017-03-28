//
//  MapViewController.swift
//  BucketList
//
//  Created by Thomas on 2/15/17.
//  Copyright © 2017 VOL. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var mapView: MKMapView!
	
	var adventure: AdventureMO?
	var searchText: String?
	var locationManager: CLLocationManager!
	var location: CLLocation!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		if searchText != nil {
			self.searchForText(text: self.searchText!)
//			self.zoomToLocation(location: <#T##CLLocation#>)
		} else if adventure != nil {
			if adventure?.address != nil {
				let loc = CLLocation.init(latitude: (adventure?.latitude)!, longitude: (adventure?.longitude)!)
				self.zoomToLocation(location: loc)
				self.searchForText(text: (adventure?.address!)!)
			} else {
				locationManager = CLLocationManager()
				locationManager.delegate = self
				locationManager.startUpdatingLocation()
				self.zoomToLocation(location: self.location)
			}
		}
    }
	
	// MARK: Location manager delegate
	
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
	
	func zoomToLocation(location: CLLocation) {
		let spanX = 0.1
		let spanY = 0.1
		var region = MKCoordinateRegion()
		region.center.latitude = location.coordinate.latitude
		region.center.longitude = location.coordinate.longitude
		region.span = MKCoordinateSpanMake(spanX, spanY)
		mapView.setRegion(region, animated: true)
	}
	
	// MARK: Search bar delegate
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		self.searchForText(text: searchText)
	}
	
	func searchForText(text: String) {
		mapView.removeAnnotations(mapView.annotations)
		
		let request = MKLocalSearchRequest()
		request.naturalLanguageQuery = text
		
		let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
		request.region = MKCoordinateRegionMake(self.location.coordinate, span)
		
		let search = MKLocalSearch(request: request)
		search.start { (response, error) in
			for mapItem in (response?.mapItems)! as [MKMapItem] {
				print("Item name: \(mapItem.name)")
			}
		}
	}
	
	func addPinToMapView(title: String, lat: CLLocationDegrees, long: CLLocationDegrees) {
		let loc = CLLocationCoordinate2D(latitude: lat, longitude: long)
		let annotation = MapAnnotation.init(coordinate: loc, title: title)
		mapView.addAnnotation(annotation)
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
