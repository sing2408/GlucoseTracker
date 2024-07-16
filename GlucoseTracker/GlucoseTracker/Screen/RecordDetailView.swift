//
//  RecordDetailView.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 10/07/24.
//

import SwiftUI
import SwiftData

struct RecordDetailView: View {
    @Environment (\.dismiss) var dismiss
    @Environment (\.colorScheme) var colorScheme
    

    @State var viewModel: GlutenDataViewModel

    
    @State private var inputNewAmountString: String = ""

    @State private var selectedType = "mg/dL"
    @State var item: GlucoseData?
    @State var isEditing: Bool = false
    @State var newAmount: Int?
    @State var newNotes: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(Font.appTitle2)
                    }

                    .padding()
                    .offset(x: -140)
                    
                    Button(action: {
                        viewModel.removeItem(item!)
                        dismiss()
                    }) {
                        Image(systemName: "trash.fill")
                            .font(Font.appTitle2)
                            .foregroundColor(.red)
                    }
                    .padding()
                    .offset(x: 140)
                }

                
                VStack {
                    Text("Sugar Level Record")
                        .font(.appTitle1)
                        .frame(width: 300)

                    if selectedType == "mMol" {
                        Text("\(String(format: "%.1f", item!.mmolAmount))")
                            .font(Font.system(size: 96, weight: .bold))
                            .frame(width: 250)
                            .padding([.top], 25)
                    } else {
                        if isEditing {
                            TextField("120", text: $inputNewAmountString.max(3))
                                .keyboardType(.numberPad)
                                .font(.system(size: 86, weight: .bold))
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
//                                .frame(maxWidth: 200)
                                .padding([.top], 25)
                                .onChange(of: inputNewAmountString) { newValue in
                                    if let value = Int(newValue), value <= 999 {
                                        newAmount = value
                                    } else if newValue.isEmpty {
                                        newAmount = nil
                                    }
                                }
                        } else {
                            Text("\(item!.amount)")

                                .font(Font.system(size: 96, weight: .bold))
                                .frame(width: 200)
                                .padding([.top], 25)
                        } else {
                            if isEditing {
                                TextField("120", value: $newAmount, format: .number)
                                    .keyboardType(.numberPad)
                                    .font(.system(size: 86, weight: .bold))
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                                    .frame(maxWidth: 200)
                                    .padding([.top], 25)
                            } else {
                                Text("\(item!.amount)")
                                    .font(Font.system(size: 96, weight: .bold))
                                    .frame(width: 200)
                                    .padding([.top], 25)
                            }
                        }
                        
                        Button(action: {
                            isEditing.toggle()
                        }) {
                            Image(systemName: "pencil")
                                .font(Font.appTitle2)
                        }
                        .padding([.top], 60)
                        .padding([.leading], -20)
                    }
                    
                    
                    Picker(selection: $selectedType) {
                        Text("mg/dL").tag("mg/dL")
                        Text("mMol").tag("mMol")
                    } label: {
                        Text("Type")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal, 120)
                
                VStack {
                    VStack(spacing: 20) {
                        List {
                            Section() {
                                HStack {
                                    Text("Type")
                                    Spacer()
                                    Text("\(item!.type)")
                                        .multilineTextAlignment(.trailing)
                                        .textFieldStyle(PlainTextFieldStyle())
                                }
                                .listRowBackground(Color(UIColor.systemBackground))
                                
                                HStack {
                                    Text("Time")
                                    Spacer()
                                    Text("\(DateFormatter.timeCustom.string(from: item!.date))")
                                        .multilineTextAlignment(.trailing)
                                        .textFieldStyle(PlainTextFieldStyle())
                                }
                                .listRowBackground(Color(UIColor.systemBackground))
                                
                                HStack {
                                    Text("Date")
                                    Spacer()
                                    Text("\(DateFormatter.fullDateCustom.string(from: item!.date))")
                                        .multilineTextAlignment(.trailing)
                                        .textFieldStyle(PlainTextFieldStyle())
                                }
                                .listRowBackground(Color(UIColor.systemBackground))
                                
                               
                                    HStack {
                                        Text("Notes")
                                        Spacer()
                                        if isEditing {
                                            TextField("Note", text: $newNotes)
                                                .frame(maxWidth: .infinity)
                                                .background(colorScheme == .dark ? .white : .clear)
                                                .background(Color(UIColor.systemBackground))
                                                .cornerRadius(2)
                                                .shadow(radius: 1)
                                        } else {
                                            Text("\(item!.notes)")
                                                .multilineTextAlignment(.trailing)
                                                .textFieldStyle(PlainTextFieldStyle())
                                        }
                                    }
                                    .listRowBackground(Color(UIColor.systemBackground))
                                
                    
                                

                            }
                        }
                        .scrollContentBackground(.hidden)
                        
                        if isEditing {
                            VStack {
                                Button(action: {
                                    
                                    if(newAmount != nil){
                                        saveEdit()
                                        isEditing.toggle()
                                    }
                                    
                                }) {
                                    Rectangle()
                                        .frame(width: 342, height: 64)
                                        .foregroundColor(.blue)
                                        .cornerRadius(12)
                                        .overlay{
                                            Text("Save")
                                                .font(.appTitle2)
                                                .foregroundColor(.white)
                                        }
                                }
                                
                                Button(action: {
                                    isEditing.toggle()
                                }) {
                                    Rectangle()
                                        .frame(width: 342, height: 64)
                                        .border(Color.blue, width: 1)
                                        .opacity(0)
                                        .cornerRadius(12)
                                        .overlay{
                                            Text("Cancel")
                                                .font(.appTitle2)
                                                .foregroundColor(.blue)
                                        }
                                }
                            }
                        }
                        
    
                        
                        
                        
                        
                    }
                }
            }
        }
    }
    
    private func saveEdit() {
        if let item {
            item.amount = newAmount!
            item.notes = newNotes
        }
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
