//
//  HapticFeedback.swift
//  GlucoseTracker
//
//  Created by Rio Ikhsan on 16/07/24.
//

import UIKit

class HapticFeedback {
    static let shared = HapticFeedback()
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    private init() {}
    
    func trigger() {
        feedbackGenerator.impactOccurred()
    }
}
