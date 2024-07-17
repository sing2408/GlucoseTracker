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
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView(modelContext: container.mainContext)
                    .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
            }
        }
        .modelContainer(container)
    }
    
    init() {
        do {
            container = try ModelContainer(for: GlucoseData.self)
        } catch {
            fatalError("Failed to create ModelContainer for Glucose data.")
        }
    }
}



