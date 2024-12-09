//
//  RouteView.swift
//  MapTracking
//
//  Created by Muhammad AbdelRahman on 06/12/2024.
//

import SwiftUI
import MapKit
import CoreLocationUI


struct RouteView: View {
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var position: MapCameraPosition = MapCameraPosition.automatic
    @State private var zoomLevel = 0.02
    @State private var route: [[CLLocationCoordinate2D]]
    
    init(route: Route) {
        
        self.route = route.segments.map { segment in
           return segment.points.map { point in
                CLLocationCoordinate2D(latitude: point.lat,
                                       longitude: point.lon)
            }
        }
    }
    
    var body: some View {
        drawMap()
            .onAppear() {
                if let location = route.first?.first {
                    position = getCameraPositionFromLocation(location)
                }
            }
    }
    
}



extension RouteView { // for draw
    private func drawMap() -> some View {
        
        let strokeStyle = StrokeStyle(
            lineWidth: 5, lineCap: .round)
        
        return Map(position: $position,
                   interactionModes: [.all]) {
            
            ForEach(route.indices) { index in
                MapPolyline(coordinates: route[index])
                    .stroke(.red, style: strokeStyle)
            }
           
           
        }.mapStyle(.hybrid)
    }
    
    private func getCameraPositionFromLocation(_ location: CLLocationCoordinate2D) -> MapCameraPosition {
        
        let span = MKCoordinateSpan(latitudeDelta: zoomLevel,
                                    longitudeDelta: zoomLevel)
        let region = MKCoordinateRegion(center: location,
                                        span: span)
        return MapCameraPosition.region(region)
    }
    
}


#Preview {
    MapView()
}
