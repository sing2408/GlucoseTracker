//
//  HomeView.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 10/07/24.


import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Environment (\.colorScheme) var colorScheme
    @State var viewModel:GlutenDataViewModel
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        
        NavigationStack{
            
            ZStack {
                LinearGradient(
                    gradient: colorScheme == .dark ? Gradient(colors: [.blue, .black]) : Gradient(colors: [.blue, .white]),
                    startPoint: .topLeading,
                    endPoint: UnitPoint(x: 0.5, y: 0.35)
                )
                
                VStack{
                    Spacer()
                    
                    Text("Summary")
                        .font(.appLargeTitle)
                        .padding([.top], 15)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    Text("\(homeViewModel.startDateString) - now")
                        .font(.appBody)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    
                    VStack{
                        Text("Average Sugar Level")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        HStack(alignment: .firstTextBaseline){
                            Text("\(viewModel.avgOverall)")
                                .font(.appAverageText)
                            Text("mg/dL")
                                .font(.appTitle2)
                        }
                        .foregroundColor(.blue)
                        
                        if viewModel.avgOverall > 140 {
                            Text("I think you should stop eating sweet ☹️")
                                .font(Font.appBody)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        } else if viewModel.avgOverall > 200 {
                            Text("NO! ARE YOU GOOD? GO VISIT DOCTOR PLEASE!")
                                .font(Font.appBody)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        } else {
                            Text("You're doing great!")
                                .font(Font.appBody)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                    }
                    .padding()
                    .padding([.bottom], 25)
                                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("Chart & Records")
                                .font(.appTitle2)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            
                            Spacer()
                            
                            NavigationLink(destination: ChartHistoryView(modelContext: viewModel.modelContext)) {
                                HStack (spacing: 0) {
                                    Text("Detail")
                                    Image(systemName: "arrow.right")
                                }
                                .foregroundStyle(.gray)
                                .opacity(0.65)
                            }
                        }
                        .padding([.leading, .trailing], 10)
                        
                        RecentCheckCard(modelContext: viewModel.modelContext)
                        
                    }
                    
                    Button{
                        homeViewModel.isShowingSheet.toggle()
                        print("Tapped")
                    } label: {
                        Rectangle()
                            .frame(width: 342, height: 64)
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                            .overlay{
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
//        .sheet(isPresented: $viewModel.isShowingSheet) {
//            AddRecordView()
//        }
    }
    
    init(modelContext: ModelContext) {
        let viewModel = GlutenDataViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}


