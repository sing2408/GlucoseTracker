//
//  RecordDetailView.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 10/07/24.
//

import SwiftUI

struct RecordDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var mealType = ["mg/dL", "mMol"]
    @State private var selectedType = "mg/dL"
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack {
                    Spacer()
                    Text("Sugar Level Record")
                        .font(.appTitle1)
                        .frame(width: 300)
                    Spacer()
                    Text("109")
                        .font(Font.system(size: 96, weight: .bold))
                        .frame(width: 200)
                    
                    Spacer()
                    
                    Picker("please select type", selection: $selectedType) {
                        ForEach(mealType, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal, 124)
                
                
                VStack {
                    VStack(spacing: 20) {
                       Form {
                            Section() {
                                HStack {
                                    Text("Type")
                                    Spacer()
                                    Text("After Meal")
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.trailing)
                                        .textFieldStyle(PlainTextFieldStyle())
                                }
                                .listRowBackground(Color(red: 0.95, green: 0.95, blue: 0.97))
                                
                                HStack {
                                    Text("Time")
                                    Spacer()
                                    Text("13.20 pm")
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.trailing)
                                        .textFieldStyle(PlainTextFieldStyle())
                                }
                                .listRowBackground(Color(red: 0.95, green: 0.95, blue: 0.97))
                                
                                HStack {
                                    Text("Date")
                                    Spacer()
                                    Text("12 July 2023")
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.trailing)
                                        .textFieldStyle(PlainTextFieldStyle())
                                }
                                .listRowBackground(Color(red: 0.95, green: 0.95, blue: 0.97))
                                
                                HStack {
                                    Text("Meal Consumed")
                                    Spacer()
                                    Text("Klatak satay")
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.trailing)
                                        .textFieldStyle(PlainTextFieldStyle())
                                }
                                .listRowBackground(Color(red: 0.95, green: 0.95, blue: 0.97))
                            }
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            }, trailing: NavigationLink(destination: RecordDetailView()) {
                Image(systemName: "pencil")
            })
        }
    }
}


#Preview {
    RecordDetailView()
}
