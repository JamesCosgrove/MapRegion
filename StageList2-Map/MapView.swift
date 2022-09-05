//
//  MapView.swift
//  StageList2-Map
//
//  Created by James Cosgrove on 26/08/2022.
//

import Foundation
import SwiftUI
import UIKit
import MapKit


//5 This is where the MapView seen previously is defined.
struct MapView: UIViewRepresentable {
	
	//6 This variable links to the selectedAnnotation variable in ContentView to keep them in sync.
	@Binding var selectedAnnotation: LandmarkAnnotation?

	//7 This is the data for the annotations to place on the map
	var forDisplay = SampleData.data
	
	//8 This is the region which encompases all the annotations in the data set.
	var region: MKCoordinateRegion {
		MKCoordinateRegion(coordinates: forDisplay.map { $0.coordinate })
	}
	
	//9 This method links a class called Coordinator (below) to the MapView, allowing the coordinator to observe changes to the map.
	func makeCoordinator() -> Coordinator {
		MapView.Coordinator(self)
	}
	
	//10 When the MapView is first added to the screen, this method is run. We don't call this, the system does.
	func makeUIView(context: Context) -> MKMapView {
		///  creating a map
		let view = MKMapView()
		/// connecting delegate with the map
		view.delegate = context.coordinator
		/// setting the region to show as the region from above (point 8)
		view.setRegion(region, animated: true)
		/// setting the map type. other options are satellite, hybrid etc.
		view.mapType = .standard
		
		// 11 This for loop adds the annotations to the map, creating a different annotation for each data point.
		for points in forDisplay {
			let annotation = LandmarkAnnotation(coordinate: points.coordinate, title: points.title)
			view.addAnnotation(annotation)
		}
		return view
	}
	
	//12 This method is called automatically when the view needs to be updated, however its not needed for now.
	func updateUIView(_ uiView: MKMapView, context: Context) { }

	//13 This is the Coordinator class mentioned eariler. It has a bunch of methods which are called automatically when things happen e.g. when an animation is selelcted or deselected.
	class Coordinator: NSObject, MKMapViewDelegate {
		
		var parent: MapView
		
		init(_ parent: MapView) {
			self.parent = parent
		}
		
		//14 This method produces an annotation view (the red circle thing) so it can be used by the map.
		func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
			guard let annotation = annotation as? LandmarkAnnotation else { return nil }
			return AnnotationView(annotation: annotation, reuseIdentifier: AnnotationView.reuseID)
		}
		
		//15 This method is called when the user selects an annotation
		func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
			var coordinates: [CLLocationCoordinate2D]
			/// if a cluster annotation is selected (an annotation representing multiple annotations which are too close to show separately), set the new region to just show the annotations represented by the cluster.
			if let cluster = annotation as? MKClusterAnnotation {
				coordinates = cluster.memberAnnotations.map { $0.coordinate }
				mapView.setRegion(MKCoordinateRegion(coordinates: coordinates), animated: true)
			}
			/// if its not a cluster annotation, just set the new region to that annotation.
			else {
				coordinates = [annotation.coordinate]
				parent.selectedAnnotation = annotation as? LandmarkAnnotation
				mapView.setRegion(MKCoordinateRegion(coordinates: [annotation.coordinate]), animated: true)
			}
		}
		
		// CARL! Now go to the file MapViewExtensions.
		
		
		
		func mapView(_ mapView: MKMapView, didDeselect annotation: MKAnnotation) {
			if let _ = annotation as? MKClusterAnnotation {
				return
			} else {
				mapView.setRegion(parent.region, animated: true)
				parent.selectedAnnotation = nil
			}
		}

	}
	
	
}








