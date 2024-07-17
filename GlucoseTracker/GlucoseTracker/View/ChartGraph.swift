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
    @Environment(\.colorScheme) var colorScheme
    @State var viewModel: GlutenDataViewModel
    
    var body: some View {
        @State var sortedItem = viewModel.items.sorted{$0.date < $1.date}
        @State var sevenRecentData = Array(sortedItem.suffix(16))
        
        Chart {
            ForEach(sevenRecentData) { item in
                LineMark(x: PlottableValue.value("Date", item.date), y: PlottableValue.value("Amount", item.amount))
                    .symbol(.circle)
                    .foregroundStyle(by: PlottableValue.value("Type", item.type))
                    .lineStyle(StrokeStyle(lineWidth: 3.75))
            }
        }
        .chartForegroundStyleScale([
            "Before eat" : Color.blue,
            "After eat" : Color.pink
        ])
        .chartLegend(alignment: .centerLastTextBaseline, spacing: 10, content: {
            LegendContent()
        })
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
    
    init(modelContext: ModelContext) {
        let viewModel = GlutenDataViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}

struct LegendContent: View {
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            HStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 12, height: 12)
                Text("Before eat")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primary)
            }
            HStack {
                Circle()
                    .fill(Color.pink)
                    .frame(width: 12, height: 12)
                Text("After eat")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primary)
            }
        }
    }
}
