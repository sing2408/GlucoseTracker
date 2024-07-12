//
//  UnitConverter.swift
//  GlucoseTracker
//
//  Created by Rio Ikhsan on 12/07/24.
//

import SwiftUI

struct UnitConverter: View {
    
    @Binding var amount: String
    @State private var unit: String = "mg/dL"
    @State private var previousUnit: String = "mg/dL"

    
    var body: some View {
        VStack {
            TextField("- - -", text: $amount)
                .keyboardType(.decimalPad)
                .font(.system(size: 80, weight: .bold))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            Picker("Unit", selection: $unit) {
                Text("mg/dL").tag("mg/dL")
                Text("mMol").tag("mMol")
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 200)
            .onChange(of: unit) { newUnit in
                convertAmount(from: previousUnit, to: newUnit)
                previousUnit = newUnit
            }
        }
    }

    private func convertAmount(from oldUnit: String, to newUnit: String) {
        guard let inputAmount = Double(amount) else {
            return // Avoid conversion if the input is not a valid number
        }
        
        if oldUnit == "mg/dL" && newUnit == "mMol" {
            let convertedValue = roundDouble(inputAmount / 18.0, toPlaces: 1)
            amount = String(format: "%.2f", convertedValue)
        } else if oldUnit == "mMol" && newUnit == "mg/dL" {
            let convertedValue = roundDouble(inputAmount * 18.0, toPlaces: 1)
            amount = String(format: "%.2f", convertedValue)
        }
    }

    private func roundDouble(_ value: Double, toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (value * divisor).rounded() / divisor
    }
}


#Preview {
    UnitConverter(amount: .constant(""))
}
