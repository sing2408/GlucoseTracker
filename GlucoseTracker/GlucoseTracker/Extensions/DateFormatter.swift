//
//  DateFormatter.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 11/07/24.
//

import Foundation

extension DateFormatter {
    static let custom: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM, yyyy"
        return formatter
    }()
}
