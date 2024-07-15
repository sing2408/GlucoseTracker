//
//  AfterEatChartGraph.swift
//  GlucoseTracker
//
//  Created by tandyys on 13/07/24.
//

import SwiftUI
import SwiftData
import Charts

struct ChartGraphByType: View {
    @State var viewModel:GlutenDataViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var chartType: String
    
    var body: some View {
        @State var sortedItem = viewModel.items.sorted{$0.date < $1.date}
        @State var sevenRecentData = Array(sortedItem.suffix(16))
        
        Chart {
            ForEach(sevenRecentData.filter{$0.type == chartType}) { item in
                LineMark(x: PlottableValue.value("Date", item.date), y: PlottableValue.value("Amount", item.amount))
                    .symbol(.circle)
                    .foregroundStyle(chartType == "Before eat" ? .blue : .pink)
                    .lineStyle(StrokeStyle(lineWidth: 3.75))
            }
        }
        .frame(width: 320, height: 220)
        .chartXAxis {
            AxisMarks(values: .stride(by: .day, count: 1)) { value in
                AxisGridLine()
                AxisTick()
                AxisValueLabel {
                    if let dateValue = value.as(Date.self) {
                        Text(dateValue, format: Date.FormatStyle()
                            .month(.abbreviated)
                            .day(.defaultDigits))
                        .font(.caption2)
                        .bold()
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(preset: .aligned, values: .automatic) { value in
                AxisGridLine()
                AxisValueLabel() {
                    if let intValue = value.as(Int.self) {
                        Text("\(intValue)")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
            }
        }
        .padding()
    }
    
    init(modelContext: ModelContext, chartType: Binding<String>) {
            let viewModel = GlutenDataViewModel(modelContext: modelContext)
            _viewModel = State(initialValue: viewModel)
            _chartType = chartType
        }
}
