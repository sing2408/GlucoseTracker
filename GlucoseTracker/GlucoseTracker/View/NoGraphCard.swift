//
//  NoGraphCard.swift
//  GlucoseTracker
//
//  Created by tandyys on 12/07/24.
//

import SwiftUI


struct NoGrapChart: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 250)
                .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
                .padding()
                .foregroundColor(.white)
            
            VStack {
                Text("Graphic stats will appear after you enter minimum of your 2 days data")
                    .frame(width: 300)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .foregroundColor(colorScheme == .dark ? .black : .black)
            }
        }
    }
}

