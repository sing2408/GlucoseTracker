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
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text("Track your current sugar level!")
                        .font(.appLargeTitle)
                        .multilineTextAlignment(.center)
                    Text("Input your current sugar level based on your glucometer result each day.")
                        .font(.appBody)
                        .padding(.top, 0.5)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                Spacer()
                
                VStack(spacing: 20) {
                    DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                        .frame(width: 100)
                    
                    VStack {
                        HStack (alignment: .firstTextBaseline) {
                            TextField("109", text: $amount)
                                .keyboardType(.numberPad)
                                .font(.system(size: 80, weight: .bold))
                                .foregroundStyle(.black)
                                .frame(maxWidth: 150)
                                .onChange(of: amount) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        amount = String(filtered.prefix(3))
                                    } else {
                                        amount = String(newValue.prefix(3))
                                    }
                            }
                            Text("mg/dl")
                            .font(.appTitle2)
                        }
                    }
                    VStack {
                        Picker(selection: $type) {
                            Text("Before Meal").tag("Before Meal")
                            Text("After Meal").tag("After Meal")
                        } label: {
                            Text("Type")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(maxWidth: 300)
                        
                        if type == "After Meal" {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Meal Consumed")
                                    .font(.subheadline)
                                TextField("Note", text: $notes)
                                    .frame(maxWidth: 300, minHeight: 40)
                                    .padding(.leading)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 1)
                            }
                            .padding(.top, 5)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .frame(maxWidth: 300)
                    
                    Button(action: {
                        saveNewRecord()
                    }, label: {
                        Text("Submit")
                            .font(.appTitle2)
                            .foregroundStyle(.white)
                            .frame(maxWidth: 300, minHeight: 50)
                            .background(.gray)
                            .cornerRadius(10)
                    })
                }
                Spacer()
            }
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func saveNewRecord() {
        guard let amountInt = Int(amount) else {
            // Handle invalid input
            alertMessage = "Please enter a valid number for the amount."
            showAlert = true
            return
        }

        let newRecord = GlucoseData(date: date, amount: amountInt, type: type, notes: notes)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "Asia/Jakarta")
        let formattedDate = formatter.string(from: newRecord.date)
        
        print("New Record:")
        print("  Date: \(formattedDate)")
        print("  Amount: \(newRecord.amount)")
        print("  Type: \(newRecord.type)")
        print("  Notes: \(newRecord.notes)")
        
        context.insert(newRecord)
        dismiss()
    }
}

#Preview {
    AddRecordView()
}
