//
////  AddDummyView.swift
////  GlucoseTracker
////
////  Created by Singgih Tulus Makmud on 10/07/24.
////
//
//import SwiftUI
//import SwiftData
//
//struct AddDummyView: View {
//    @Environment(\.modelContext) var modelContext
//    @Environment(\.dismiss) var dismiss
//    
//    @State private var type: String = ""
//    @State private var amount: Double = 0
//    @State private var date: Date = .now
//    @State private var notes: String = ""
//    
//    var body: some View {
//        VStack {
//            Form{
//                DatePicker("Date", selection: $date, displayedComponents: .date)
//                DatePicker("Time", selection: $date, displayedComponents: .hourAndMinute)
//                TextField("Type", text: $type)
//                TextField("Sugar Level", value: $amount, format: .number)
//                    .keyboardType(.numberPad)
//                TextField("Notes", text: $notes)
//            }
//            
//            Button("Save") {
////                let data = GlucoseData(date: date, amount: amount, type: type, notes: notes)
////                modelContext.insert(data)
////                dismiss()
//            }
//            
//        }
//
//    }
//}
//
//#Preview {
//    AddDummyView()
//        .modelContainer(for: GlucoseData.self)
//}
