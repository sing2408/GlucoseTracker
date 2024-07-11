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
    @State var type: String = ""
    @State var notes: String = ""
    
    var body: some View {
        Form{
            Section{
                TextField("Glucose Level", text: $amount)
                    .keyboardType(.numberPad)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                Picker(selection: $type) {
                    Text("Before Meal")
                    Text("After Meal")
                } label: {
                    Text("Type")
                }
                TextField("Note", text: $notes)

            }
            Button(action: {
                saveNewRecord()
                dismiss()
            }, label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
            })
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
