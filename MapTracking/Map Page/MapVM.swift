//
//  MapVM.swift
//  MapTracking
//
//  Created by Muhammad AbdelRahman on 06/12/2024.
//

import Foundation


class MapVM: ObservableObject {
    @Published var locationManger: LocationManager
    
    init(locationManger: LocationManager = LocationManager()) {
        self.locationManger = locationManger
        self.locationManger.requestLocation()
    }
}
