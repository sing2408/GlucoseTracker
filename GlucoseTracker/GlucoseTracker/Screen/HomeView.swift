//
//  HomeView.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 10/07/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        
        NavigationStack{
            
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.gray, .white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                VStack{
                    Spacer()
                    
                    Text("Summary")
                        .font(.appLargeTitle)
                    
                    Text("\(viewModel.startDateString) - \(viewModel.endDateString)")
                        .font(.appBody)
                    
                    
                    VStack{
                        Text("Average Sugar Level")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .firstTextBaseline){
                            Text("120")
                                .font(.appAverageText)
                            Text("mg/dl")
                                .font(.appTitle2)
                        }
                        
                        Text("You're doing great!")
                            .font(.appBody)
                    }
                    .padding()
                    
                    
                    VStack(alignment: .leading){
                        
                        HStack{
                            Text("Chart & Record")
                                .font(.appTitle2)
                            
                            Spacer()
                            
                            NavigationLink(destination: HomeDummyView()) {
                                Text("Details")
                                Image(systemName: "chevron.right")
                                
                            }
                        }
                        
                        ChartRecordCard()
                        
                    }
                    .padding()
                    
                    Button{
                        viewModel.isShowingSheet.toggle()
                    } label: {
                        Rectangle()
                            .frame(width: 342, height: 64)
                            .foregroundColor(.gray)
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
                .padding()
            }
            .ignoresSafeArea()
        }
        .sheet(isPresented: $viewModel.isShowingSheet) {
            AddRecordView()
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: GlucoseData.self)
    
}

