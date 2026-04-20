//
//  ContentView.swift
//  MapKit_Practice
//
//  Created by 태원진 on 4/16/26.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var position: MapCameraPosition = .automatic
    @State private var result: CLLocationCoordinate2D?
    let searchKeyword: String = "호미곶 등대"
    
    
    var body: some View {
        Map(position: $position) {
            if let result {
                Marker(searchKeyword,
                       systemImage: "lighthouse.fill",
                       coordinate: result)
            }
        }
        .onAppear { search() }
    }
    
    
    private func search() {
        let req = MKLocalSearch.Request()
        req.naturalLanguageQuery = searchKeyword
        MKLocalSearch(request: req).start { response, _ in
            guard let item = response?.mapItems.first else { return }
            let coord = item.location.coordinate
            result = coord
            position = .region(.init(center: coord, latitudinalMeters: 1000, longitudinalMeters: 1000))
            
        }
    }
}





#Preview {
    ContentView()
}
