//
//  ChartHistoryView.swift
//  GlucoseTracker
//
//  Created by tandyys on 12/07/24.
//

import SwiftUI
import SwiftData

struct ChartHistoryView: View {
    @Environment (\.colorScheme) var colorScheme
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
            
            if viewModel.items.count < 4 {
                NoGrapChart()
            } else {
                ZStack {
                    ChartCard()
                    VStack {
                        ChartCardAvg(modelContext: viewModel.modelContext)
                        ChartGraph(modelContext: viewModel.modelContext)
                    }
                }
            }
            
            Text("History")
                .font(Font.appTitle2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HistoryList(modelContext: viewModel.modelContext)
        }
        .offset(y: viewModel.items.count < 4 ? -20 : 0)
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
