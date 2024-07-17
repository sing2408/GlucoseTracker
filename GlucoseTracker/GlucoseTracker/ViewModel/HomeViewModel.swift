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
    @Published var isShowingSheet: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    
    init() {
        let calendar = Calendar.current
        let now = Date()
        
        let endDate = calendar.startOfDay(for: now)
        let startDate = calendar.date(byAdding: .day, value: -7, to: endDate)!
        
        self.startDateString = DateFormatter.custom.string(from: startDate)
        self.endDateString = DateFormatter.custom.string(from: endDate)
    }
    
    func toggleSheet() {
        isShowingSheet.toggle()
        print(isShowingSheet)
    }
    
    func backgroundColor(avgOverall: Int) -> LinearGradient {
        if avgOverall > 140 && avgOverall < 200 {
            return LinearGradient(
                gradient: colorScheme == .dark ? Gradient(colors: [.orange, .black]) : Gradient(colors: [.orange, .white]),
                startPoint: .topLeading,
                endPoint: UnitPoint(x: 0.4, y: 0.3)
            )
        } else if avgOverall >= 200 {
            return LinearGradient(
                gradient: colorScheme == .dark ? Gradient(colors: [.red, .black]) : Gradient(colors: [.red, .white]),
                startPoint: .topLeading,
                endPoint: UnitPoint(x: 0.4, y: 0.3)
            )
        } else if avgOverall < 140 && avgOverall != 0 {
            return LinearGradient(
                gradient: colorScheme == .dark ? Gradient(colors: [.green, .black]) : Gradient(colors: [.green, .white]),
                startPoint: .topLeading,
                endPoint: UnitPoint(x: 0.4, y: 0.3)
            )
        } else {
            return LinearGradient(
                gradient: colorScheme == .dark ? Gradient(colors: [.blue, .black]) : Gradient(colors: [.blue, .white]),
                startPoint: .topLeading,
                endPoint: UnitPoint(x: 0.4, y: 0.3)
            )
        }
    }
    
    func averageColor(avgOverall: Int) -> Color {
            switch avgOverall {
            case 0:
                return .blue
            case 1..<140:
                return .green
            case 140..<200:
                return .orange
            default:
                return .red
            }
        }
    
}

