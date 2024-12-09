//
//  LocationManager.swift
//  MapTracking
//
//  Created by Muhammad AbdelRahman on 06/12/2024.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
        manager.startUpdatingLocation()
        requestAuthorization()
    }
    
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
}
 
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }

    
}
