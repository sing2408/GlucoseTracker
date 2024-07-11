//
//  HomeViewModel.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 11/07/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var startDateString: String
    @Published var endDateString: String
    @Published var isShowingSheet = false
    
    init() {
        let calendar = Calendar.current
        let now = Date()
        
        // Calculate the start and end dates
        let endDate = calendar.startOfDay(for: now)
        let startDate = calendar.date(byAdding: .day, value: -6, to: endDate)!
        
        // Create the date range strings using the custom DateFormatter
        self.startDateString = DateFormatter.custom.string(from: startDate)
        self.endDateString = DateFormatter.custom.string(from: endDate)
    }
    
    func toggleSheet() {
        isShowingSheet.toggle()
    }
}

