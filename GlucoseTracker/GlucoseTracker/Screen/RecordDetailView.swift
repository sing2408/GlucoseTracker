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
    @State private var selectedType = "mg/dL"
    let item: GlucoseData
    
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(Font.appTitle2)
                }
                .padding()
                .offset(x: -160)
                
                VStack {
                    Text("Sugar Level Record")
                        .font(.appTitle1)
                        .frame(width: 300)
                    if selectedType == "mMol" {
                        Text("\(String(format: "%.1f", item.mmolAmount))")
                            .font(Font.system(size: 96, weight: .bold))
                            .frame(width: 200)
                            .padding([.top], 25)
                    } else {
                        Text("\(item.amount)")
                            .font(Font.system(size: 96, weight: .bold))
                            .frame(width: 200)
                            .padding([.top], 25)
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
                                    Text("\(item.type)")
                                        .multilineTextAlignment(.trailing)
                                        .textFieldStyle(PlainTextFieldStyle())
                                }
                                .listRowBackground(Color(UIColor.systemBackground))
                                
                                HStack {
                                    Text("Time")
                                    Spacer()
                                    Text("\(DateFormatter.timeCustom.string(from: item.date))")
                                        .multilineTextAlignment(.trailing)
                                        .textFieldStyle(PlainTextFieldStyle())
                                }
                                .listRowBackground(Color(UIColor.systemBackground))
                                
                                HStack {
                                    Text("Date")
                                    Spacer()
                                    Text("\(DateFormatter.fullDateCustom.string(from: item.date))")
                                        .multilineTextAlignment(.trailing)
                                        .textFieldStyle(PlainTextFieldStyle())
                                }
                                .listRowBackground(Color(UIColor.systemBackground))
                                
                                if item.type == "After eat" {
                                    HStack {
                                        Text("Food Consumed")
                                        Spacer()
                                        Text("\(item.notes)")
                                            .multilineTextAlignment(.trailing)
                                            .textFieldStyle(PlainTextFieldStyle())
                                    }
                                    .listRowBackground(Color(UIColor.systemBackground))
                                }
                                
                            }
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
            }
        }
    }
}
