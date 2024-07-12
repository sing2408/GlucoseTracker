//
//  HomeView.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 10/07/24.


import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State var viewModel:GlutenDataViewModel
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        
        NavigationStack{
            
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.blue, .white]),
                    startPoint: .top,
                    endPoint: UnitPoint(x: 0.5, y: 0.15)
                )
                
                VStack{
                    Spacer()
                    
                    Text("Summary")
                        .font(.appLargeTitle)
                    
                    Text("\(homeViewModel.startDateString) - now")
                        .font(.appBody)
                    
                    
                    VStack{
                        Text("Average Sugar Level")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .firstTextBaseline){
                            Text("120")
                                .font(.appAverageText)
                            Text("mg/dL")
                                .font(.appTitle2)
                        }
                        .foregroundColor(.blue)
                        
                        Text("You're doing great!")
                            .font(.appBody)
                    }
                    .padding()
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("Chart & Record")
                                .font(.appTitle2)
                            
                            Spacer()
                            
                            Text("Detail>")
                                .foregroundStyle(.gray)
                                .opacity(0.65)
                                .bold()
                        }
                        
                        ChartRecordCard()
                        
                    }
                    .padding()
                    
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

//#Preview {
//    HomeView()
//        .modelContainer(for: GlucoseData.self)
//    
//}

