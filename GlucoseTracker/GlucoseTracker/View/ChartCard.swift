//
//  ChartCard.swift
//  GlucoseTracker
//
//  Created by tandyys on 12/07/24.
//

import SwiftUI

struct ChartCard: View {
    @Environment (\.colorScheme) var colorScheme
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 350, height: 300)
            .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
            .padding()
            .foregroundColor(colorScheme == .dark ? .black : .white)
    }
}

#Preview {
    ChartCard()
}
