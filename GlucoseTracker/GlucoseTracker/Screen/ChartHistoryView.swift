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
    @StateObject var viewModel:GlutenDataViewModel
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
            
            ScrollView {
                if viewModel.items.count < 4 {
                    NoGrapChart()
                } else {
                    if chartType == "All" {
                        ZStack {
                            ChartCard()
                            VStack {
                                ChartCardAvg(modelContext: viewModel.modelContext)
                                ChartGraph(modelContext: viewModel.modelContext)
                            }
                        }
                    } else if chartType == "Before eat" {
                        ZStack {
                            ChartCard()
                            ChartGraphByType(modelContext: viewModel.modelContext, chartType: $chartType)
                                .padding()
                        }
                    } else {
                        ZStack {
                            ChartCard()
                            ChartGraphByType(modelContext: viewModel.modelContext, chartType: $chartType)
                                .padding()
                        }
                    }
                }
                
                Text("History")
                    .font(Font.appTitle2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                if chartType == "All" {
                    HistoryList(modelContext: viewModel.modelContext)
                } else if chartType == "Before eat" {
                    HistoryListByType(modelContext: viewModel.modelContext, type: chartType)
                } else if chartType == "After eat" {
                    HistoryListByType(modelContext: viewModel.modelContext, type: chartType)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .ignoresSafeArea(edges: .bottom)
        .offset(y: viewModel.items.count < 4 ? -20 : 0)
        .padding()
    }

    init(modelContext: ModelContext) {
        let viewModel = GlutenDataViewModel(modelContext: modelContext)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}
