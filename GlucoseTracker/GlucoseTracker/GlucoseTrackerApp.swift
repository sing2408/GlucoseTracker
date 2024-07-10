//
//  GlucoseTrackerApp.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 10/07/24.
//

import SwiftUI
import SwiftData

@main

struct GlucoseTrackerApp: App {
    var container: ModelContainer {
            do {
                let container = try ModelContainer(for: GlucoseData.self)
                return container
            } catch {
                fatalError("Failed to create container")
            }
        }
    
    var body: some Scene {
        WindowGroup {
            HomeDummyView()
        }
        .modelContainer(container)
    }
}
