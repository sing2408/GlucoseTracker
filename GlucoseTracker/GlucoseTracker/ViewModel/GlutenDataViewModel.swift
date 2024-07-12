//
//  GlutenDataViewModel.swift
//  GlucoseTracker
//
//  Created by tandyys on 12/07/24.
//

import Foundation
import SwiftData

class GlutenDataViewModel:ObservableObject {
    var modelContext: ModelContext
    @Published var items: [GlucoseData] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchItems()
    }
    
    func addItem(_ date: Date, _ amount: Int, _ type: String, _ notes: String) {
        let item = GlucoseData(date: date, amount: amount, type: type, notes: notes)
        modelContext.insert(item)
        fetchItems()
    }
    
    func removeItem(_ item: GlucoseData) {
        modelContext.delete(item)
        fetchItems()
    }
    
    func fetchItems() {
        do {
            let descriptor = FetchDescriptor<GlucoseData>()
            items = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
    
    var latestItem: GlucoseData? {
        items.last
    }
    
    var avgOverall: Int {
        let calendar = Calendar.current
        let sevenDaysAgo = calendar.date(byAdding: .day, value: -14, to: Date())!
        
        let lastSevenDaysData = items.filter { $0.date >= sevenDaysAgo }
        let totalAmount = lastSevenDaysData.reduce(0) { $0 + $1.amount}
        
        guard !lastSevenDaysData.isEmpty else { return 0 }
        
        return totalAmount / lastSevenDaysData.count
    }
    
    var avgBeforeMeal: Int {
        let calendar = Calendar.current
        let sevenDaysAgo = calendar.date(byAdding: .day, value: -14, to: Date())!
        
        let lastSevenDaysData = items.filter { $0.date >= sevenDaysAgo && $0.type == "Before eat"}
        let totalAmount = lastSevenDaysData.reduce(0) { $0 + $1.amount}
        
        guard !lastSevenDaysData.isEmpty else { return 0 }
        
        return totalAmount / lastSevenDaysData.count
    }
    
    var avgfAfterMeal: Int {
        let calendar = Calendar.current
        let sevenDaysAgo = calendar.date(byAdding: .day, value: -14, to: Date())!
        
        let lastSevenDaysData = items.filter { $0.date >= sevenDaysAgo && $0.type == "After eat"}
        let totalAmount = lastSevenDaysData.reduce(0) { $0 + $1.amount}
        
        guard !lastSevenDaysData.isEmpty else { return 0 }
        
        return totalAmount / lastSevenDaysData.count
    }
    
}
