//
//  AddDummyView.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 10/07/24.
//

import SwiftUI
import SwiftData

struct AddDummyView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var type: String = ""
    @State private var amount: Int = 0
    @State private var date: Date = .now
    
    var body: some View {
        VStack {
            Form{
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Type", text: $type)
                TextField("Sugar Level", value: $amount, format: .number)
                    .keyboardType(.numberPad)
            }
            
            Button("Save") {
                let data = GlucoseData(date: date, amount: amount, type: type)
                modelContext.insert(data)
                dismiss()
            }
            
        }

    }
}

#Preview {
    AddDummyView()
        .modelContainer(for: GlucoseData.self)
}
