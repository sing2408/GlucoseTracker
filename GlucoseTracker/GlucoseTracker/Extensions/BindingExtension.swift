//
//  BindingExtension.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 16/07/24.
//

import SwiftUI

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(limit))
            }
        }
        return self
    }
}
