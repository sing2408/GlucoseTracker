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
    @Environment (\.colorScheme) var colorScheme
    
    class DetailManager: ObservableObject{
            
        @Published var selectedItem: GlucoseData?
        @Published var showDetail: Bool = false
        }
        

    @StateObject var manager = DetailManager()
    
    @State var viewModel: GlutenDataViewModel
    @Binding var selectedType: String
    
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
            VStack(spacing: 0) {
                ForEach(viewModel.items.reversed().filter{$0.type == selectedType}) { item in
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(item.amount > 140 && item.amount < 200 ? .yellow : item.amount > 200 ? .red : .green)
                            .font(.system(size: 42))
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: item.type == "Before eat" ? "takeoutbag.and.cup.and.straw" : "takeoutbag.and.cup.and.straw.fill")
                                    .foregroundColor(item.type == "Before eat" ? .blue : .pink)
                                    .font(.system(size: 18))
                                
                                Text(item.type == "Before eat" ? "Before eat" : "After eat")
                                    .font(Font.appBody)
                                    .foregroundColor(item.type == "Before eat" ? .blue : .pink)
                                    .bold()
                            }
                            HStack(spacing: 0) {
                                Text("\(item.amount)")
                                    .font(Font.appTitle1)
                                Text("mg/dL")
                                    .foregroundStyle(.gray)
                                    .opacity(0.75)
                                    .bold()
                                    .font(.system(size: 17))
                            }
                        }
                        //.frame(width: 170)
                        
                        Spacer()
                        
                        Text("\(DateFormatter.custom.string(from: item.date))")
                            .foregroundStyle(.gray)
                            .opacity(0.75)
                            //.frame(width: 100)
                        
                        Spacer()
                        
                        Button(action: {
                            manager.selectedItem = item
                            manager.showDetail.toggle()
                        }) {
                            Image(systemName: "info.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.blue)
                                .frame(width: 17)
                        }
                    }
                    //.frame(width: 350)        
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 1)
                    .padding(.horizontal)
                    
                    if colorScheme == .dark {
                        Divider()
                    }
                    
                    Spacer()
                    
                }
                .onDelete { indexes in
                    for index in indexes {
                        let originIndex = viewModel.items.count - 1 - index
                        viewModel.removeItem(viewModel.items[originIndex])
                    }
                }
            }

            .sheet(isPresented: $manager.showDetail) {
                if let selectedItem = manager.selectedItem {
                    RecordDetailView(item: selectedItem)
                        .presentationDetents([.height(650)])
                } else {
                    NoDataView()
                        .presentationDetents([.height(650)])
                }
            }
        }
    }
    
    init(modelContext: ModelContext, type: Binding<String>) {
        let viewModel = GlutenDataViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
        _selectedType = type
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}

