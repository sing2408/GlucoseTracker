//
//  ChartCardAvg.swift
//  GlucoseTracker
//
//  Created by tandyys on 12/07/24.
//

import SwiftUI
import SwiftData

struct ChartCardAvg: View {
    @State var viewModel: GlutenDataViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Before meal avg.")
                    .opacity(0.6)
                HStack(spacing: 0) {
                    Text("\(viewModel.avgBeforeMeal)")
                        .font(Font.system(size: 24))
                        .bold()
                    Text("mg/dL")
                        .bold()
                }
            }
            .foregroundColor(.blue)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("After meal avg.")
                    .opacity(0.6)
                HStack(spacing: 0) {
                    Text("\(viewModel.avgfAfterMeal)")
                        .font(Font.system(size: 24))
                        .bold()
                    Text("mg/dL")
                        .bold()
                }
            }
            .foregroundColor(.pink)
        }
        .frame(width: 300)
        .offset(y: 15)
    }
    
    init(modelContext: ModelContext) {
        let viewModel = GlutenDataViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}
