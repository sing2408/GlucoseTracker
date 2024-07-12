//
//  HideKeyboard.swift
//  GlucoseTracker
//
//  Created by tandyys on 12/07/24.
//

import Foundation
import UIKit

extension SampleAddRecordView {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
