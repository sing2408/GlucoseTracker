//
//  User.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 10/07/24.
//

import SwiftUI
import SwiftData

@Model
class User {
    var name: String
    //var average: Double
    init(name: String) {
        self.name = name
    }
}
