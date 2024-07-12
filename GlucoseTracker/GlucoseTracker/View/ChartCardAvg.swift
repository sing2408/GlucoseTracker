//
//  ChartCardAvg.swift
//  GlucoseTracker
//
//  Created by tandyys on 12/07/24.
//

import SwiftUI

struct ChartCardAvg: View {
    @State var avgBeforeEat:String = "128"
    @State var avgAfterEat:String = "253"
    
    var body: some View {
        HStack {
            VStack {
                Text("Before meal avg.")
                    .opacity(0.6)
                HStack(spacing: 0) {
                    Text("\(avgBeforeEat)")
                        .font(Font.system(size: 24))
                        .bold()
                    Text("mg/dL")
                        .bold()
                }
            }
            .foregroundColor(.blue)
            
            Spacer()
            
            VStack {
                Text("After meal avg.")
                    .opacity(0.6)
                HStack(spacing: 0) {
                    Text("\(avgAfterEat)")
                        .font(Font.system(size: 24))
                        .bold()
                    Text("mg/dL")
                        .bold()
                }
            }
            .foregroundColor(.pink)
        }
        .padding()
    }
}

#Preview {
    ChartCardAvg()
}
