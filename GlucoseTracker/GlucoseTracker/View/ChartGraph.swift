//
//  RecentChart.swift
//  GlucoseTracker
//
//  Created by tandyys on 12/07/24.
//

import SwiftUI
import SwiftData
import Charts

struct ChartGraph: View {
    @State var viewModel: GlutenDataViewModel
    
    var body: some View {
        Chart {
            ForEach(viewModel.items) { item in
                LineMark(x: PlottableValue.value("Date", item.date), y: PlottableValue.value("Amount", item.amount))
            }
        }
    }
    
    init(modelContext: ModelContext) {
        let viewModel = GlutenDataViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}

//#Preview {
//    RecentChart()
//}
