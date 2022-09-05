//
//  ContentView.swift
//  StageList2-Map
//
//  Created by James Cosgrove on 26/08/2022.
//

import SwiftUI

//2 This is the view you see on the screen
struct ContentView: View {
	
	//3 This variable keeps track of which annotation has been tapped
	@State var selectedAnnotation: LandmarkAnnotation? = nil
	
	
	var body: some View {
		//4 This is the map view you see. It covers the whole screen due to the .edgesIgnoringSafeArea modifier.
		MapView(selectedAnnotation: $selectedAnnotation)
			.edgesIgnoringSafeArea(.vertical)
	}
}

// CARL! Go to the file called MapView




struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
