//
//  Manageable.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 16/07/24.
//

import Foundation

protocol Addable {
    func addItem(_ date: Date, _ amount: Int, _ type: String, _ notes: String)
}
