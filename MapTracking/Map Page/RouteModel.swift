//
//  RouteModel.swift
//  MapTracking
//
//  Created by Muhammad AbdelRahman on 07/12/2024.
//

import Foundation

import SwiftData

@Model
class Route: Identifiable {
    let id = UUID()
    var date: Date
    var segments: [Segment]
    var name: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        return formatter.string(from: date)
    }
    init(date: Date, segments: [Segment]) {
        self.date = date
        self.segments = segments
    }
}

@Model
class Point {
    var lat: Double
    var lon: Double
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}

@Model
class Segment {
    var points: [Point]
    init(points: [Point]) {
        self.points = points
    }
}
