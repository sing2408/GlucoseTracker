//
//  Fetchable.swift
//  GlucoseTracker
//
//  Created by Singgih Tulus Makmud on 16/07/24.
//

import Foundation

protocol Fetchable {
    var items: [GlucoseData] { get }
    func fetchItems()
}
