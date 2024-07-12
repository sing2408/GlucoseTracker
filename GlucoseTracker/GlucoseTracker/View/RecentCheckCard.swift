//
//  RecentCheckCard.swift
//  GlucoseTracker
//
//  Created by tandyys on 12/07/24.
//

import SwiftUI
import SwiftData

struct RecentCheckCard: View {
    @State var viewModel: GlutenDataViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(height: 300)
            .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
            .foregroundColor(.white)
            .padding()
            .overlay {
                VStack {
                    Rectangle()
                        .frame(maxWidth: 350, maxHeight: 220)
                        .foregroundColor(.green)
                        .opacity(0.6)
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
                        
                        VStack {
                            Text("Recent Check Up")
                                .font(.system(size: 17))
                                .bold()
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
    
    init(modelContext: ModelContext) {
        let viewModel = GlutenDataViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}

//#Preview {
//    RecentCheckCard()
//}
