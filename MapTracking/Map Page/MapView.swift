//
//  MapView.swift
//  MapTracking
//
//  Created by Muhammad AbdelRahman on 06/12/2024.
//

import SwiftUI
import MapKit
import CoreLocationUI


struct MapView: View {
    
    private enum TrackingStatus {
        case start
        case pause
        case resume
        case finished
    }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.modelContext) private var context
    @ObservedObject var viewModel: MapVM = MapVM()
    @State private var position: MapCameraPosition = MapCameraPosition.automatic
    @State private var zoomLevel = 0.02
    @State private var segment: [CLLocationCoordinate2D] = []
    @State private var route: [[CLLocationCoordinate2D]] = []
    @State private var trackingStatus: TrackingStatus = .finished
    @State private var mapGesture = false
    
    var body: some View {
        ZStack {
            drawMap()
                .onReceive(viewModel.locationManger.$location) { newLocation in
                    if let newLocation = newLocation {
                        
                        if  trackingStatus == .finished
                                || trackingStatus == .pause {
                            
                            if position == .automatic {
                                position = getCameraPositionFromLocation(newLocation)
                            }
                        }
                        
                        else if isNewPos(lc1: newLocation, lc2: position.region?.center) {
                            print("New Pos ==> ", newLocation)
                            segment.append(newLocation)
                            position = getCameraPositionFromLocation(newLocation)
                        }
                        
                    }
                    
                }
            
            drawTrackingActionButtons()
        }.onChange(of: trackingStatus) {
            switch trackingStatus {
            case .start:
                segment = []
            case .pause:
                route.append(segment)
                segment = []
            case .resume:
                break
            case .finished:
                route.append(segment)
                saveRoute()
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    
    
    
}

extension MapView { // swiftData Handeling
    private func saveRoute() {
        let modelRoute = Route(date: Date(),
                               segments: route.map { segment in
            Segment(points: segment.map { point in
                Point(lat: point.latitude, lon: point.longitude)
            })
        })
        context.insert(modelRoute)
    }
}

extension MapView { // for draw
    private func drawMap() -> some View {
        
        let strokeStyle = StrokeStyle(
            lineWidth: 5, lineCap: .round)
        
        return Map(position: $position,
                   interactionModes: [.all]) {
            
            ForEach(route.indices) { index in
                MapPolyline(coordinates: route[index])
                    .stroke(.red, style: strokeStyle)
            }
            MapPolyline(coordinates: segment)
                .stroke(.blue, style: strokeStyle)
           
           
        }.mapStyle(.hybrid)
            .onMapCameraChange(frequency: .continuous, { context in
               if  fabs(zoomLevel - context.region.span.longitudeDelta) >= 0.0005,
                   position != .automatic {
                    zoomLevel = context.region.span.longitudeDelta
                }
            })
            
        
        
    }
    
    private func drawTrackingActionButtons() -> some View {
        VStack(alignment: .center,
               spacing: 20) {
            Spacer()
            Button("Start Tracking") {
                trackingStatus = .start
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
            Button("Pause Tracking") {
                trackingStatus = .pause
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
            Button("Resume Tracking") {
                trackingStatus = .resume
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
            Button("Stop Tracking") {
                trackingStatus = .finished
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
        }
    }
}

extension MapView {
    
    private func getCameraPositionFromLocation(_ location: CLLocationCoordinate2D) -> MapCameraPosition {
        
        let span = MKCoordinateSpan(latitudeDelta: zoomLevel,
                                    longitudeDelta: zoomLevel)
        let region = MKCoordinateRegion(center: location,
                                        span: span)
        return MapCameraPosition.region(region)
    }
    
   private func isNewPos(lc1: CLLocationCoordinate2D?,
                  lc2: CLLocationCoordinate2D?,
                  epsilon: CLLocationDegrees = 0.0005) -> Bool {
       if let lc1 = lc1, let lc2 = lc2 {
           return fabs(lc1.latitude - lc2.latitude) >= epsilon
           || fabs(lc1.longitude - lc2.longitude) >= epsilon
       } else {
           return true
       }
        

    }
}

#Preview {
    MapView()
}
