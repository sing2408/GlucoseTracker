//
//  AddRecordView.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 10/07/24.
//

import SwiftUI

struct AddRecordView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @State var date: Date = Date()
    @State var amount: String = ""
    @State var type: String = "After Meal"
    @State var notes: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                DatePicker("", selection: $date, displayedComponents: .date)
                    .padding()
                
                VStack {
                    Text("Track your current sugar level!")
                        .font(.appLargeTitle)
                        .multilineTextAlignment(.center)
                    Text("Input your current sugar level based on your glucometer result each day.")
                        .font(.appBody)
                        .padding(.top, 0.5)
                        .multilineTextAlignment(.center)
                } .padding()
                Spacer()
                VStack(spacing: 20){
                    
                    TextField("- - -", text: $amount)
                        .keyboardType(.numberPad)
                        .font(.system(size: 80, weight: .bold))
                        .foregroundStyle(.appTertiary)
                        .multilineTextAlignment(.center)
                        .onChange(of: amount) { newValue in
                            // Filter out non-numeric characters and restrict to 3 digits
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                amount = String(filtered.prefix(3))
                            } else {
                                amount = String(newValue.prefix(3))
                            }
                        }
                    
                    Picker(selection: $type) {
                        Text("Before Meal").tag("Before Meal")
                        Text("After Meal").tag("After Meal")
                    } label: {
                        Text("Type")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(maxWidth: 300)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        if type == "After Meal" {
                            Text("Meal Consumed")
                                .font(.subheadline)
                            TextField("Note", text: $notes)
                                .frame(maxWidth: 300, maxHeight: 50)
                                .padding(.leading)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 1)

                        }
                    }
                    .frame(maxWidth: 300, maxHeight: 70)
                    .padding()
                    
                    Button(action: {
                        saveNewRecord()
                        dismiss()
                    }, label: {
                        Text("Save")
                            .font(.appTitle2)
                            .foregroundStyle(.white)
                            .frame(maxWidth: 300, maxHeight: 50)
                            .background(.appTertiary)
                            .cornerRadius(10)
                    })
                }
                Spacer()
            }
        }
    }
    func saveNewRecord(){
        guard let amountInt = Int(amount) else {
            // Handle invalid input
            return
        }
        
        let newRecord = GlucoseData( date: date, amount: amountInt, type: type, notes: notes)
        context.insert(newRecord)
        dismiss()
    }
    
}

#Preview {
    AddRecordView()
}
