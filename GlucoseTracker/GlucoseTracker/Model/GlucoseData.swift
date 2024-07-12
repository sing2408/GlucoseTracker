//
//  GlucoseData.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 10/07/24.
//

import SwiftUI
import SwiftData

@Model
class GlucoseData:Identifiable {
    var id = UUID().uuidString
    var date: Date
    var amount: Int
    var mmolAmount: Double {
        return Double(amount / 18)
    }
    var type: String = "Before eat"
    var notes: String = ""
    
    init(id: String = UUID().uuidString, date: Date, amount: Int, type: String, notes: String) {
        self.id = id
        self.date = date
        self.amount = amount
        self.type = type
        self.notes = notes
    }
}
