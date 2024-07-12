//
//  HistoryList.swift
//  GlucoseTracker
//
//  Created by tandyys on 12/07/24.
//

import SwiftUI
import SwiftData

struct HistoryList: View {
    @State var viewModel: GlutenDataViewModel
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
                ForEach(viewModel.items.reversed()) { item in
                    HStack {
                        Text(dateFormatter.string(from: item.date))
                        Divider()
                        VStack {
                            Text("\(String(item.amount)) mg/dL")
                            Text("\(String(item.mmolAmount)) mmol/L")
                        }
                        Divider()
                        Text(item.type)
                    }
                    .padding()
                }
                .onDelete { indexes in
                    for index in indexes {
                        let originIndex = viewModel.items.count - 1 - index
                        viewModel.removeItem(viewModel.items[originIndex])
                    }
                }
            }
        }
    }
    
    init(modelContext: ModelContext) {
        let viewModel = GlutenDataViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}

//#Preview {
//    HistoryList()
//}
