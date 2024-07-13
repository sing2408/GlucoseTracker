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
                        Image(systemName: item.type == "Before eat" ? "takeoutbag.and.cup.and.straw" : "takeoutbag.and.cup.and.straw.fill")
                            .foregroundColor(item.type == "Before eat" ? .blue : .pink)
                            .font(.system(size: 36))
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("\(item.type)")
                                .font(Font.appBody)
                                .foregroundColor(item.type == "Before eat" ? .blue : .pink)
                                .bold()
                            HStack(spacing: 0){
                                Text("\(item.amount)")
                                    .font(Font.appTitle2)
                                Text("mg/dL")
                                    .foregroundStyle(.gray)
                                    .opacity(0.75)
                                    .bold()
                            }
                        }
                        Spacer()
                        Text("\(DateFormatter.custom.string(from: item.date))")
                            .foregroundStyle(.gray)
                            .opacity(0.75)
                            .frame(width: 100)
                    }
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
