//
//  RecentCheckCard.swift
//  GlucoseTracker
//
//  Created by tandyys on 12/07/24.
//

import SwiftUI
import SwiftData

struct RecentCheckCard: View {
    @ObservedObject var viewModel: GlutenDataViewModel
    
    var body: some View {
        
        NavigationLink(destination: ChartHistoryView(modelContext: viewModel.modelContext)) {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 350, height: 250)
                .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
                .foregroundColor(.white)
                .padding()
                .overlay {
                    VStack {
                        Image("RecentGraph")
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
                            
                            VStack(alignment: viewModel.latestItem?.amount != nil ? .leading : .center) {
                                Text("Recent Check Up")
                                    .frame(width: 150)
                                    .font(.system(size: 17))
                                    .bold()
                                    .foregroundStyle(.black)
                                Text(viewModel.latestItem?.amount != nil ? "\(viewModel.latestItem!.amount)mg/dL" : "--mg/dL")
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
                                    .frame(width: 150)
                                    .bold()
                            }
                            .padding()
                            
                            Spacer()
                            
                            if viewModel.latestItem?.date != nil {
                                Text(DateFormatter.custom.string(from: viewModel.latestItem!.date))
                                    .foregroundStyle(.gray)
                                    .opacity(0.7)
                                    .frame(width: 100)
                                    .offset(y: -5)
                            } else {
                                Text(" ")
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
