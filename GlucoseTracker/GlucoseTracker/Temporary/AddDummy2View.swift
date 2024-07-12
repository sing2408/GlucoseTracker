////
////  AddDummy2View.swift
////  GlucoseTracker
////
////  Created by Rio Ikhsan on 12/07/24.
////
//
//import SwiftUI
//
//struct AddDummy2View: View {
//    
//    @Environment(\.dismiss) var dismiss
//    @Environment(\.modelContext) var context
//    
//    @State var date: Date = Date()
//    @State var amount: String = ""
//    @State var type: String = "After Meal"
//    @State var notes: String = ""
//    
//    @State private var showAlert = false
//    @State private var alertMessage = ""
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                VStack {
//                    Text("Track your current sugar level!")
//                        .font(.appLargeTitle)
//                        .multilineTextAlignment(.center)
//                    Text("Input your current sugar level based on your glucometer result each day.")
//                        .font(.appBody)
//                        .padding(.top, 0.5)
//                        .multilineTextAlignment(.center)
//                }
//                .padding()
//                
//                Spacer()
//                
//                VStack(spacing: 20) {
//                    DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
//                        .frame(width: 100)
//                    
//                    TestConverter2(amount: $amount)
//                    
//                    VStack {
//                        Picker(selection: $type) {
//                            Text("Before Meal").tag("Before Meal")
//                            Text("After Meal").tag("After Meal")
//                        } label: {
//                            Text("Type")
//                        }
//                        .pickerStyle(SegmentedPickerStyle())
//                        .frame(maxWidth: 300)
//                        
//                        if type == "After Meal" {
//                            VStack(alignment: .leading, spacing: 5) {
//                                Text("Meal Consumed")
//                                    .font(.subheadline)
//                                TextField("Note", text: $notes)
//                                    .frame(maxWidth: 300, minHeight: 40)
//                                    .padding(.leading)
//                                    .background(Color.white)
//                                    .cornerRadius(10)
//                                    .shadow(radius: 1)
//                            }
//                            .padding(.top, 5)
//                        }
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 2)
//                    .frame(maxWidth: 300)
//                    
//                    Button(action: {
//                        saveNewRecord()
//                    }, label: {
//                        Text("Submit")
//                            .font(.appTitle2)
//                            .foregroundStyle(.white)
//                            .frame(maxWidth: 300, minHeight: 50)
//                            .background(.gray)
//                            .cornerRadius(10)
//                    })
//                }
//                Spacer()
//            }
//            .navigationBarItems(leading: Button("Cancel") {
//                dismiss()
//            })
//            .alert(isPresented: $showAlert) {
//                Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//            }
//        }
//    }
//    
//    func saveNewRecord() {
//        guard let amountDouble = Double(amount) else {
//            // Handle invalid input
//            alertMessage = "Please enter a valid number for the amount."
//            showAlert = true
//            return
//        }
//        
//        let newRecord = GlucoseData(date: date, amount: amountDouble, type: type, notes: notes)
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        formatter.timeZone = TimeZone(identifier: "Asia/Jakarta")
//        let formattedDate = formatter.string(from: newRecord.date)
//        
//        print("New Record:")
//        print("  Date: \(formattedDate)")
//        print("  Amount: \(newRecord.amount)")
//        print("  Type: \(newRecord.type)")
//        print("  Notes: \(newRecord.notes)")
//
//        context.insert(newRecord)
//        dismiss()
//    }
//}
//
//#Preview {
//    AddDummy2View()
//}
