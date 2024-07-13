//
//  NoDataView.swift
//  GlucoseTracker
//
//  Created by tandyys on 13/07/24.
//

import SwiftUI

struct NoDataView: View {
    @Environment (\.dismiss) var dismiss
    @Environment (\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            Text("Please try one more time on another data.")
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .bold()
                .font(Font.appTitle2)
                .presentationDetents([.height(650)])
            Button(action: {
                dismiss()
            }) {
                Rectangle()
                    .frame(width: 300, height: 50)
                    .foregroundColor(.blue)
                    .cornerRadius(12)
                    .overlay{
                        Text("Try Again")
                            .font(.appTitle2)
                            .foregroundColor(.white)
                    }
            }
            .padding([.top], 25)
        }
    }
}

#Preview {
    NoDataView()
}
