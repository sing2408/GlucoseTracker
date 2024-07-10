//
//  GlucoseData.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 10/07/24.
//

import SwiftUI
import SwiftData

@Model
class GlucoseData {
    var date: Date
    var amount: Int
    var type: String
    
    init(date: Date, amount: Int, type: String) {
        self.date = date
        self.amount = amount
        self.type = type
    }
}
