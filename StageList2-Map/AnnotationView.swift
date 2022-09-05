//
//  AnnotationView.swift
//  StageList2-Map
//
//  Created by James Cosgrove on 05/09/2022.
//

import MapKit

let clusterID = "cluster"

class AnnotationView: MKMarkerAnnotationView {
	static let reuseID = "venueAnnotation"
	
	override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
		super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
		clusteringIdentifier = clusterID
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForDisplay() {
		super.prepareForDisplay()
		displayPriority = .defaultLow
	}
}
