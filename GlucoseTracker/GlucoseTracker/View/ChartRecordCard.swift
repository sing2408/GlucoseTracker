//
//  ChartRecordCard.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 11/07/24.
//

import SwiftUI

struct ChartRecordCard: View {
    var body: some View {
        Rectangle()
            .frame(width: 361, height: 272)
            .foregroundColor(.gray)
            .cornerRadius(16)
            .overlay {
                UnevenRoundedRectangle(cornerRadii: .init(
                    bottomLeading: 16,
                    bottomTrailing: 16
                ))
                .frame(height: 92)
                .foregroundColor(.white)
                .overlay {
                    HStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .foregroundColor(.appSecondary)
                            .frame(width: 60, height: 60)
                        
                        VStack(alignment: .leading) {
                            Text("Recent check up")
                                .font(.appBody)
                                .bold()
                            
                            HStack(alignment: .firstTextBaseline) {
                                Text("120")
                                    .font(.appLargeTitle)
                                Text("mg/dl")
                                    .font(.appBody)
                            }
                        }
                        .padding()
                        Spacer()
                        
                        VStack {
                            Spacer()
                            Text("June")
                                .font(.footnote)
                        }
                    }
                    .padding()
                }
                .offset(y: 92)
            }
    }
}


