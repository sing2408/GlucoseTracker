import Foundation
import SwiftData

class GlutenDataViewModel: ObservableObject, Addable ,Removable, Fetchable {
    var modelContext: ModelContext
    @Published var items: [GlucoseData] = []
    @Published var avgOverall: Int = 0
    @Published var avgBeforeMeal: Int = 0
    @Published var avgAfterMeal: Int = 0
    
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchItems()
    }
    
    
    func addItem(_ date: Date, _ amount: Int, _ type: String, _ notes: String) {
        let item = GlucoseData(date: date, amount: amount, type: type, notes: notes)
        modelContext.insert(item)
        fetchItems()
//        updateAverages()
    }
    
    func removeItem(_ item: GlucoseData) {
        modelContext.delete(item)
        fetchItems()
//        updateAverages()
    }
    
    func fetchItems() {
        do {
            let descriptor = FetchDescriptor<GlucoseData>()
            items = try modelContext.fetch(descriptor)
            updateAverages()
        } catch {
            print("Fetch failed")
        }
    }
    
    var latestItem: GlucoseData? {
        return items.sorted{$0.date > $1.date}.first
    }
    
    private func updateAverages() {
        avgOverall = calculateAvgOverall()
        avgBeforeMeal = calculateAvgBeforeMeal()
        avgAfterMeal = calculateAvgAfterMeal()
    }
    
    private func calculateAvgOverall() -> Int {
        let calendar = Calendar.current
        let fourteenDaysAgo = calendar.date(byAdding: .day, value: -14, to: Date())!
        
        let lastFourteenDaysData = items.filter { $0.date >= fourteenDaysAgo }
        let totalAmount = lastFourteenDaysData.reduce(0) { $0 + $1.amount }
        
        guard !lastFourteenDaysData.isEmpty else { return 0 }
        
        return totalAmount / lastFourteenDaysData.count
    }
    
    private func calculateAvgBeforeMeal() -> Int {
        let calendar = Calendar.current
        let fourteenDaysAgo = calendar.date(byAdding: .day, value: -14, to: Date())!
        
        let lastFourteenDaysData = items.filter { $0.date >= fourteenDaysAgo && $0.type == "Before eat" }
        let totalAmount = lastFourteenDaysData.reduce(0) { $0 + $1.amount }
        
        guard !lastFourteenDaysData.isEmpty else { return 0 }
        
        return totalAmount / lastFourteenDaysData.count
    }
    
    private func calculateAvgAfterMeal() -> Int {
        let calendar = Calendar.current
        let fourteenDaysAgo = calendar.date(byAdding: .day, value: -14, to: Date())!
        
        let lastFourteenDaysData = items.filter { $0.date >= fourteenDaysAgo && $0.type == "After eat" }
        let totalAmount = lastFourteenDaysData.reduce(0) { $0 + $1.amount }
        
        guard !lastFourteenDaysData.isEmpty else { return 0 }
        
        return totalAmount / lastFourteenDaysData.count
    }
}
