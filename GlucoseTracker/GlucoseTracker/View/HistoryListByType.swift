//
//  HistoryListByType.swift
//  GlucoseTracker
//
//  Created by tandyys on 15/07/24.
//

import SwiftUI
import SwiftData

struct HistoryListByType: View {
    @Environment (\.dismiss) var dismiss
    
    @State var viewModel: GlutenDataViewModel
    @State var selectedItem: GlucoseData?
    @State var showDetail: Bool = false
    @State var selectedType: String
    
    var body: some View {
        if viewModel.items.isEmpty {
            HStack {
                Image(systemName: "exclamationmark.circle.fill")
                    .foregroundColor(.yellow)
                    .offset(x: 15)
                Text("You don't have any history data")
                    .frame(height: 200)
                    .padding()
                    .foregroundColor(.pink)
            }
        } else {
            List {
                ForEach(viewModel.items.reversed().filter{ $0.type == selectedType}) { item in
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(item.amount > 140 && item.amount < 200 ? .yellow : item.amount > 200 ? .red : .green)
                            .font(.system(size: 36))
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: item.type == "Before eat" ? "takeoutbag.and.cup.and.straw" : "takeoutbag.and.cup.and.straw.fill")
                                    .foregroundColor(item.type == "Before eat" ? .blue : .pink)
                                    .font(.system(size: 17))
                                Text(item.type == "Before eat" ? "Before eat" : "After eat")
                                    .font(.system(size: 14))
                                    .foregroundColor(item.type == "Before eat" ? .blue : .pink)
                                    .bold()
                            }
                            HStack(spacing: 0){
                                Text("\(item.amount)")
                                    .font(Font.appTitle2)
                                Text("mg/dL")
                                    .foregroundStyle(.gray)
                                    .opacity(0.75)
                                    .bold()
                                    .font(.system(size: 14))
                            }
                        }
                        
                        Spacer()

                        Text("\(DateFormatter.custom.string(from: item.date))")
                            .foregroundStyle(.gray)
                            .opacity(0.75)
                            .frame(width: 100)
                        
                        Spacer()
                        
                        Button(action: {
                            self.selectedItem = item
                            self.showDetail.toggle()
                        }) {
                            Image(systemName: "info.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.blue)
                                .frame(width: 17)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .onDelete { indexes in
                    for index in indexes {
                        let originIndex = viewModel.items.count - 1 - index
                        viewModel.removeItem(viewModel.items[originIndex])
                    }
                }
                .sheet(isPresented: $showDetail) {
                    if let selectedItem = selectedItem {
                        RecordDetailView(item: selectedItem)
                            .presentationDetents([.height(650)])
                    } else {
                        NoDataView()
                            .presentationDetents([.height(650)])
                    }
                }
            }
        }
    }
    
    init(modelContext: ModelContext, type: String) {
        let viewModel = GlutenDataViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
        self.selectedType = type
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}

