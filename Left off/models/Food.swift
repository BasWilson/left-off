//
//  Food.swift
//  Left off
//
//  Created by Bas Wilson on 11/12/2023.
//

import Foundation
import SwiftData

@Model
final class Food: Identifiable {
    
    var id: String = UUID().uuidString
    var name: String
    var timestamp: Date
    
    init(
        timestamp: Date,
        name: String,
        id: String = UUID().uuidString
    ) {
        self.id = id
        self.timestamp = timestamp
        self.name = name
    }
}
