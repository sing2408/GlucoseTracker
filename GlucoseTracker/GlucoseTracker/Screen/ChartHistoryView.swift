//
//  ChartHistoryView.swift
//  GlucoseTracker
//
//  Created by tandyys on 12/07/24.
//

import SwiftUI
import SwiftData

struct ChartHistoryView: View {
    @State var viewModel:GlutenDataViewModel
    @State private var chartType:String = "All"
    
    var body: some View {
        VStack {
            Text("Chart & Records")
                .font(Font.appTitle1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Picker("Select Option", selection: $chartType) {
                Text("All").tag("All")
                Text("Before eat").tag("Before eat")
                Text("After eat").tag("After eat")
            }
            .pickerStyle(SegmentedPickerStyle())
            ZStack {
                ChartCard()
                ChartCardAvg()
                    .padding()
                    .offset(y: -115)
            }
            Text("History")
                .font(Font.appTitle2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HistoryList(modelContext: viewModel.modelContext)
        }
        .padding()
    }
    
    init(modelContext: ModelContext) {
        let viewModel = GlutenDataViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}

//#Preview {
//    ChartHistoryView()
//}
