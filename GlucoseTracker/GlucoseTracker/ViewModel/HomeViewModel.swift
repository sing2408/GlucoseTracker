//
//  HomeViewModel.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 11/07/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    var startDateString: String
    var endDateString: String
    var isShowingSheet = false
    
    init() {
        let calendar = Calendar.current
        let now = Date()
        
        // Calculate the start and end dates
        let endDate = calendar.startOfDay(for: now)
        let startDate = calendar.date(byAdding: .day, value: -7, to: endDate)!
        
        // Create the date range strings using the custom DateFormatter
        self.startDateString = DateFormatter.custom.string(from: startDate)
        self.endDateString = DateFormatter.custom.string(from: endDate)
    }
    
    func toggleSheet() {
        isShowingSheet.toggle()
    }
}

