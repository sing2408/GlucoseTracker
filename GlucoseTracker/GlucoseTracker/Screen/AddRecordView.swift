//
//  AddRecordView.swift
//  GlucoseTracker
//
//  Created by tandyys on 13/07/24.
//

import SwiftUI
import SwiftData

struct AddRecordView: View {
    
    @ObservedObject var viewModel:GlutenDataViewModel
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State private var inputAmountString: String = ""
    @State private var isError: Bool = false
    
    @State private var inputAmount:Int? = nil
    @State private var selectedType:String = "Before eat"
    @State private var inputDate:Date = .now
    @State private var inputNotes: String = ""
    
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(Font.appTitle2)
                }
                Spacer()
            }
            .padding()
            
            //            .offset(x: -170, y: selectedType == "After eat" ? 0 : -38)
            
            VStack {
                VStack(alignment: .center) {
                    Text("Track your current sugar level")
                    //Text("sugar level!")
                }
                .font(Font.appLargeTitle)
                .multilineTextAlignment(.center)

                .frame(width: 350)

                
                VStack {
                    Text("Input your current sugar level based on your glucometer result each day.")
                    //Text("glucometer result each day.")
                }
                .font(Font.appBody)
                .foregroundColor(.gray)
                .opacity(0.75)
                .multilineTextAlignment(.center)

                .padding([.top], -5)
                .frame(width: 300)

                
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
                
                
                
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    TextField("120", text: $inputAmountString.max(3))
                        .keyboardType(.numberPad)
                        .font(.system(size: 76, weight: .bold))
                        .foregroundStyle(Color.primary)
                        .frame(maxWidth: 150)
                        .onChange(of: inputAmountString) { newValue in
                            if let value = Int(newValue), value <= 999 {
                                inputAmount = value
                            } else if newValue.isEmpty {
                                inputAmount = nil
                            }
                        }
                    
                    Text("mg/dL")
                        .font(.appTitle2)
                }
                
                if isError {
                    Text("Please enter a valid amount.")
                        .font(.subheadline)
                        .foregroundColor(.red)
                } else{
                    Text("Enter your glucose level")
                        .font(.subheadline)
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
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Notes")
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
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(10)
                .shadow(radius: 2)
                .frame(maxWidth: 300)
                
                Button(action: {
                    
                    if ((inputAmount) != nil) {
                        viewModel.addItem(inputDate, inputAmount!, selectedType, inputNotes)
                        inputAmount = nil
                        selectedType = "Before eat"
                        hideKeyboard()
                        dismiss()
                        //viewModel.fetchItems()
                    }
                    else {
                        print("not yet filled")
                        isError.toggle()
                    }
                    
                    
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
//        .onTapGesture {
//            hideKeyboard()
//        }
    }
}

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(limit))
            }
        }
        return self
    }
}
