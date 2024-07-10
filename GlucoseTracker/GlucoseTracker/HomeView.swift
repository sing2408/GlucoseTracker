//
//  HomeView.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 10/07/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.appBackground
            
            VStack {
                Spacer()
                VStack (alignment: .leading){
                    Text("This Week")
                        .font(.appLargeTitle)
                    Rectangle()
                        .frame(width: 329, height: 185)
                        .cornerRadius(16)
                        .foregroundColor(.appSecondary)
                        .overlay {
                            VStack{
                                Text("Avg. Sugar Level")
                                    .font(.appTitle2)
                                    .foregroundColor(.appPrimary)
                                HStack{
                                    Text("120")
                                        .font(.appAverageText)
                                        .foregroundColor(.appPrimary)
                                    Text("mg/dl")
                                        .font(.appTitle2)
                                        .foregroundColor(.appPrimary)
                                }
                                Text("Keep it up, Bryan!")
                                    .font(.appBody)
                                    .foregroundColor(.appPrimary)
                            }
                            
                        }
                }
                
                Spacer()
                
                VStack (alignment: .leading){
                    Text("Chart & Record")
                        .font(.appTitle2)
                    
                    Rectangle()
                        .frame(width: 329, height: 185)
                        .cornerRadius(16)
                        .foregroundColor(.appTertiary)
                    
                    Rectangle()
                        .frame(width: 329, height: 112)
                        .cornerRadius(16)
                        .foregroundColor(.appPrimary)
                        .overlay{
                            HStack{
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .foregroundColor(.appSecondary)
                                    .frame(width: 60, height: 60)
                                VStack{
                                    Text("Recent check up")
                                        .font(.appBody)
                                        .bold()
                                    HStack{
                                        Text("120")
                                            .font(.appLargeTitle)
                                        Text("mg/dl")
                                            .font(.appBody)
                                            .bold()
                                    }
                                }
                            }
                        }
                }
                
                
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.appSecondary)
                    .padding()
                
                
                
            }
            .padding()
            
        }
        .ignoresSafeArea()
    }
}



#Preview {
    HomeView()
        .modelContainer(for: GlucoseData.self)
    
}

