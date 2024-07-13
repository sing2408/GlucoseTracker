//
//  AddRecordView.swift
//  GlucoseTracker
//
//  Created by tandyys on 13/07/24.
//

import SwiftUI
import SwiftData

struct AddRecordView: View {
    
    @State var viewModel:GlutenDataViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var inputAmount:Int? = nil
    @State private var selectedType:String = "Before eat"
    @State private var inputDate:Date = .now
    @State private var inputNotes: String = ""
    
    
    var body: some View {
        VStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(Font.appTitle2)
            }
            .padding()
            .offset(x: -170, y: selectedType == "After eat" ? 0 : -38)
            
            VStack {
                VStack(alignment: .center) {
                    Text("Track your current")
                    Text("sugar level!")
                }
                .font(Font.appLargeTitle)
                .multilineTextAlignment(.center)
                
                VStack {
                    Text("Input your current sugar level based on your")
                    Text("glucometer result each day.")
                }
                .font(Font.appBody)
                .foregroundColor(.gray)
                .opacity(0.75)
                .multilineTextAlignment(.center)
                .padding([.top], -5)
                
                HStack {
                    DatePicker("", selection: $inputDate, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .accentColor(.blue)
                        .labelsHidden()
                    DatePicker("", selection: $inputDate, displayedComponents: .hourAndMinute)
                        .datePickerStyle(CompactDatePickerStyle())
                        .accentColor(.blue)
                        .labelsHidden()
                }
                .padding([.top], 30)
                
                HStack (alignment: .firstTextBaseline, spacing: 0) {
                    TextField("120", value: $inputAmount, format: .number)
                        .keyboardType(.numberPad)
                        .font(.system(size: 76, weight: .bold))
                        .foregroundStyle(.black)
                        .frame(maxWidth: 150)
                    Text("mg/dL")
                        .font(.appTitle2)
                }
                
                VStack {
                    Picker(selection: $selectedType) {
                        Text("Before eat").tag("Before eat")
                        Text("After eat").tag("After eat")
                    } label: {
                        Text("Type")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(maxWidth: 300)
                    
                    if selectedType == "After eat" {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Food Consumed")
                                .font(.subheadline)
                            TextField("Note", text: $inputNotes)
                                .frame(maxWidth: 300, minHeight: 40)
                                .padding(.leading)
                                .background(Color(UIColor.systemBackground))
                                .cornerRadius(10)
                                .shadow(radius: 1)
                        }
                        .padding(.top, 5)
                    }
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(10)
                .shadow(radius: 2)
                .frame(maxWidth: 300)
                
                Button(action: {
                    viewModel.addItem(inputDate, inputAmount!, selectedType, inputNotes)
                    inputAmount = nil
                    selectedType = "Before eat"
                    hideKeyboard()
                    dismiss()
                    viewModel.fetchItems()
                }) {
                    Rectangle()
                        .frame(width: 342, height: 64)
                        .foregroundColor(.blue)
                        .cornerRadius(12)
                        .overlay{
                            Text("Submit")
                                .font(.appTitle2)
                                .foregroundColor(.white)
                        }
                }
                .padding([.top], 25)
            }
        }
    }
    
    init(modelContext: ModelContext) {
        let viewModel = GlutenDataViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}
