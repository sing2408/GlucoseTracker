import SwiftUI
import SwiftData
import UIKit

struct HomeView: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    @ObservedObject var viewModel: GlutenDataViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                homeViewModel.backgroundColor(avgOverall: viewModel.avgOverall, colorScheme: colorScheme)
                
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
                        .foregroundColor(homeViewModel.averageColor(avgOverall: viewModel.avgOverall))
                        
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
                            
                            NavigationLink(destination: ChartHistoryView(modelContext: viewModel.modelContext).onDisappear {
                                viewModel.fetchItems()
                            }) {
                                HStack(spacing: 0) {
                                    Text("See More")
                                    
                                }
                                .font(.appBody)
                            }
                        }
                        .padding()
                        
                        RecentCheckCard(modelContext: viewModel.modelContext)
                        
                    }
                    Spacer()
                    
                    Button {

                        
                        homeViewModel.toggleSheet()
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
        
        .sheet(isPresented: $homeViewModel.isShowingSheet) {
            AddRecordView(viewModel: viewModel)
                .presentationDetents([.height(650)])
        }
        .onAppear{
            viewModel.fetchItems()
        }
    }
    
    init(modelContext: ModelContext) {
        _viewModel = ObservedObject(wrappedValue: GlutenDataViewModel(modelContext: modelContext))
    }
}
