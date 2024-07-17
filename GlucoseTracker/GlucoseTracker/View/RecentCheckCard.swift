//
//  RecentCheckCard.swift
//  GlucoseTracker
//
//  Created by tandyys on 12/07/24.
//

import SwiftUI
import SwiftData

struct RecentCheckCard: View {
    @Environment (\.colorScheme) var colorScheme
    @ObservedObject var viewModel: GlutenDataViewModel
    
    var body: some View {
        
        NavigationLink(destination: ChartHistoryView(modelContext: viewModel.modelContext)) {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 350, height: 250)
                .shadow(color: Color.gray.opacity(0.7), radius: 8, x: 0, y: 5)
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .padding(.horizontal)
                .overlay {
                    VStack {
                        Image(colorScheme == .dark ? "DarkModeChart" : "RecentGraph")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                        HStack {
                            if viewModel.items.isEmpty {
                                Text(" ")
                            } else {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(viewModel.latestItem.map{
                                        item in
                                        switch item.amount {
                                        case let amount where amount > 200:
                                            return Color.red
                                        case let amount where amount < 200 && amount > 140:
                                            return Color.yellow
                                        case let amount where amount < 140 :
                                            return Color.green
                                        default:
                                            return Color.gray
                                        }
                                    } ?? .gray)
                                    .font(.system(size: 50))
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Recent Check Up")
                                    .font(.system(size: 17))
                                    .bold()
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                                
                                Text(viewModel.items.sorted{$0.date > $1.date}.first != nil ? "\(String(viewModel.items.sorted{$0.date > $1.date}.first!.amount))mg/dL" : "--mg/dL")
                                    .font(Font.appTitle2)
                                    .foregroundStyle(viewModel.latestItem.map { item in
                                        switch item.amount {
                                        case let amount where amount > 200:
                                            return Color.red
                                        case let amount where amount > 140:
                                            return Color.yellow
                                        default:
                                            return Color.green
                                        }
                                    } ?? .gray)
                                    .bold()
                            }
                            
                            Spacer()
                            
                            if viewModel.items.isEmpty {
                                Text("")
                            } else {
                                Text(DateFormatter.custom.string(from: viewModel.sortData().first!.date))
                            }
                        }
                        .frame(width: 350)
                        .offset(x: viewModel.items.isEmpty ? 0 : 10,
                                y: viewModel.items.isEmpty ? 0 : -5
                        )
                    }
                }
        }
        
    }
    
    init(modelContext: ModelContext) {
        let viewModel = GlutenDataViewModel(modelContext: modelContext)
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
}
