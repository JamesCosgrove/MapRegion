//
//  MapViewExtension.swift
//  StageList2-Map
//
//  Created by James Cosgrove on 30/08/2022.
//

import MapKit


/* A coordinate region is made up of a centre coordinate (latitude and longitude) and a span (how wide and tall to crop in)
 The code below creates a custom was to create a coordinate region just using an array of coordinates, instead of defining a centre and span.
 */
extension MKCoordinateRegion {

	//This is the initilizer, the method where the coordinate region is created.
	init(coordinates: [CLLocationCoordinate2D]) {
		//Define some min/max limits
		var minLat: CLLocationDegrees = 90.0
		var maxLat: CLLocationDegrees = -90.0
		var minLon: CLLocationDegrees = 180.0
		var maxLon: CLLocationDegrees = -180.0

		//Iterate over the coordinates passed to the initilizer, finding the min/max lat/long values.
		for coordinate in coordinates {
			let lat = Double(coordinate.latitude)
			let long = Double(coordinate.longitude)
			if lat < minLat {
				minLat = lat
			}
			if long < minLon {
				minLon = long
			}
			if lat > maxLat {
				maxLat = lat
			}
			if long > maxLon {
				maxLon = long
			}
		}

		// Set the span based on the distance between the top and bottom, and leftmost and rightmost coordiantes.
		var span = MKCoordinateSpan(
			latitudeDelta: (maxLat - minLat),
			longitudeDelta: (maxLon - minLon)
		)

		// Set the center based on the rectangular span found above.
		let center = CLLocationCoordinate2D(
			latitude: maxLat - span.latitudeDelta / 2,
			longitude: maxLon - span.longitudeDelta / 2
		)
		
		// Add a bit of padding to the span otherwide the text or red circle for the annotations will be cut off
		span.latitudeDelta = span.latitudeDelta * 1.2
		span.longitudeDelta = span.longitudeDelta * 1.2
		
		/*
		 Inside this initialiser, somewhere, is where the improvements need to go. I think there are a few ways to do it, but i think the best would be to find where the highest density of points are and show that region.
		 
		 Some things to note:
			- On an iPhone, the screen is not big enough to show two points that are very far apart as the map will not zoom out enough.
			- Need to consider how the code will work when operating near the international date line (when the max and min lat and long reset)
			- If we go with the above approach, it would be good to know the number of annotations being show, so we can have a bit of text that says "showing x of y anotations".
			- When you tap on an annotation, it zooms to show it centered on the screen. This behavior needs to be presereved.
		 
		 Extension ;)
			- The new design of the app is going to have a map with a sheet which partially covers the bottom half of the map when an annotation is touched, similar to the official maps app. Can you think of a way to set the region so it is skewed to the top half of the screen? i.e. the same annotations are shown but zoomed out so they fit in the top half.
		 */
		
		
		self.init(center: center, span: span)
	}
}


// Don't worry about this
extension MKCoordinateSpan: Comparable {
	public static func == (lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
		lhs.latitudeDelta == rhs.latitudeDelta && lhs.longitudeDelta == rhs.longitudeDelta
	}
	
	public static func < (lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
		lhs.latitudeDelta < rhs.latitudeDelta && lhs.longitudeDelta < rhs.longitudeDelta
	}
}

