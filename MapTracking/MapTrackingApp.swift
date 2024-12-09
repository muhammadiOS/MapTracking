//
//  MapTrackingApp.swift
//  MapTracking
//
//  Created by Muhammad AbdelRahman on 05/12/2024.
//

import SwiftUI
import SwiftData

@main
struct MapTrackingApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Route.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            LandingView()
        }
        .modelContainer(sharedModelContainer)
    }
}
