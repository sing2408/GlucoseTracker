import SwiftUI
import SwiftData
import UIKit

struct HomeView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: GlutenDataViewModel
    @StateObject var homeViewModel = HomeViewModel()
    @State var isShowingSheet = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                if viewModel.avgOverall > 140 && viewModel.avgOverall < 200 {
                    LinearGradient(
                        gradient: colorScheme == .dark ? Gradient(colors: [.orange, .black]) : Gradient(colors: [.orange, .white]),
                        startPoint: .topLeading,
                        endPoint: UnitPoint(x: 0.4, y: 0.3)
                    )
                } else if viewModel.avgOverall > 200 {
                    LinearGradient(
                        gradient: colorScheme == .dark ? Gradient(colors: [.red, .black]) : Gradient(colors: [.red, .white]),
                        startPoint: .topLeading,
                        endPoint: UnitPoint(x: 0.4, y: 0.3)
                    )
                } else if viewModel.avgOverall < 140 && viewModel.avgOverall != 0 {
                    LinearGradient(
                        gradient: colorScheme == .dark ? Gradient(colors: [.green, .black]) : Gradient(colors: [.green, .white]),
                        startPoint: .topLeading,
                        endPoint: UnitPoint(x: 0.4, y: 0.3)
                    )
                } else {
                    LinearGradient(
                        gradient: colorScheme == .dark ? Gradient(colors: [.blue, .black]) : Gradient(colors: [.blue, .white]),
                        startPoint: .topLeading,
                        endPoint: UnitPoint(x: 0.4, y: 0.3)
                    )
                }
                
                VStack {
                    Spacer()
                    
                    Text("Summary")
                        .font(.appLargeTitle)
                        .padding([.top], 15)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    Text("\(homeViewModel.startDateString) - now")
                        .font(.appBody)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    VStack {
                        Text("Average Sugar Level")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        HStack(alignment: .firstTextBaseline) {
                            Text("\(viewModel.avgOverall)")
                                .font(.appAverageText)
                            Text("mg/dL")
                                .font(.appTitle2)
                        }
                        .foregroundColor(viewModel.avgOverall > 140 && viewModel.avgOverall < 200 ? .orange : viewModel.avgOverall > 200 ? .red : viewModel.avgOverall < 140 && viewModel.avgOverall != 0 ? .green : .blue)
                        
                        if viewModel.avgOverall > 140 {
                            Text("Be more aware of your meals!")
                                .font(Font.appBody)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        } else if viewModel.avgOverall > 200 {
                            Text("Be careful, sugar levels high!")
                                .font(Font.appBody)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        } else {
                            Text("You're doing great!")
                                .font(Font.appBody)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                    }
                    .padding()
                    
                                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Chart & Records")
                                .font(.appTitle2)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            
                            Spacer()
                            
                            NavigationLink(destination: ChartHistoryView(modelContext: viewModel.modelContext)) {
                                HStack(spacing: 0) {
                                    Text("See More")
//                                    Image(systemName: "greaterthan")
//                                        .font(.appBody)
                                }
                                .font(.appBody)
                                //.opacity(0.65)
                            }
                        }
                        .padding()
                        
                        RecentCheckCard(modelContext: viewModel.modelContext)
                        
                    }
                    
                    Spacer()
                    
                    Button {
                        
                        isShowingSheet.toggle()
                        HapticFeedback.shared.trigger()

                    } label: {
                        Rectangle()
                            .frame(width: 342, height: 64)
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                            .overlay {
                                Text("Add New Record")
                                    .font(.appTitle2)
                                    .foregroundColor(.white)
                            }
                    }
                    .padding()
                    
                    Spacer()
                    
                }
                .offset(y: 25)
                .padding()
            }
            .ignoresSafeArea()
        }
        .sheet(isPresented: $isShowingSheet) {
            AddRecordView(viewModel: viewModel)
                .presentationDetents([.height(650)])
        }
    }
    
    init(modelContext: ModelContext) {
        _viewModel = ObservedObject(wrappedValue: GlutenDataViewModel(modelContext: modelContext))
    }
}
