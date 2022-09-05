//
//  Annotation.swift
//  StageList2-Map
//
//  Created by James Cosgrove on 05/09/2022.
//

import MapKit

struct SampleData: Identifiable {
	var id = UUID()
	var latitude: Double
	var longitude: Double
	var title: String
	var coordinate: CLLocationCoordinate2D {
		CLLocationCoordinate2D(
			latitude: latitude,
			longitude: longitude)
	}
}

extension SampleData {
	static var data = [
		SampleData(latitude: 51.5941, longitude: -0.1298, title: "Alexandra Palace"),
		SampleData(latitude: 51.5030, longitude: 0.0032, title: "The O2"),
		SampleData(latitude: 51.465107, longitude: -0.114922, title: "O2 Academy Brixton"),
		SampleData(latitude: 51.5522, longitude: -0.1422, title: "O2 Forum Kentish Town"),
		SampleData(latitude: 52.1907, longitude: 0.1359, title: "Cambridge Junction"),
		// Here is where you can add new coordinates.
	]
}


class LandmarkAnnotation: NSObject, MKAnnotation {
	let coordinate: CLLocationCoordinate2D
	let title: String?
	
	init(coordinate: CLLocationCoordinate2D, title: String) {
		self.coordinate = coordinate
		self.title = title
		super.init()
	}
}


