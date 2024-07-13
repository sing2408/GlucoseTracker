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
            Text("Track your current sugar level!")
                .font(Font.appLargeTitle)
                .multilineTextAlignment(.center)
            Text("Input your current sugar level based on your glucometer result each day.")
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
                        Text("Meal Consumed")
                            .font(.subheadline)
                        TextField("Note", text: $inputNotes)
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
            
        }
    }
    
    init(modelContext: ModelContext) {
        let viewModel = GlutenDataViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}
