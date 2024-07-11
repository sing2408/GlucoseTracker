//
//  RecordDetailView.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 10/07/24.
//

import SwiftUI

struct RecordDetailView: View {
    var mealType = ["Before Meal", "After Meal"]
    @State private var selectedType = "Before Meal"
    @State private var mealNumber: String = ""
    
    var body: some View {
        VStack {
            Text("Record Detail")
                .font(.appTitle1)
            
            Spacer()
            
            Text("Sugar Level")
                .font(.appTitle2)
            Spacer()
            
            Text("120")
                .font(.appAverageText)
            Spacer()
            
            Text("miligram/desiliter")
                .font(.appTitle2)
        }
        .background(.orange)
        
        VStack {
            Picker("please select type", selection: $selectedType) {
                ForEach(mealType, id: \.self) {
                    Text($0)
                }
            }.pickerStyle(.palette)
        }
        
        VStack(alignment: .leading) {
            Text("Meal consumed")
            
            Form {
                TextField(text: $mealNumber, prompt: Text("Add notes about your meal...")) {
                }
            }
            .scrollContentBackground(.hidden)
           
            VStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Add Sugar Level")
                        .font(.appTitle2)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(Color(.appSecondary))
                        .cornerRadius(10)
                })
                .padding(.horizontal, 47)
            }
        }
        .padding(.horizontal, 16)
        .background(.gray)
    }
    
}

#Preview {
    RecordDetailView()
}
