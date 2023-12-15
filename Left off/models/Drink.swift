//
//  Food.swift
//  Left off
//
//  Created by Bas Wilson on 11/12/2023.
//

import Foundation
import SwiftData

enum DrinkType {
    case water
    case coffee
    case soda
}

@Model
final class DrinkDay: Identifiable {
    
    var id: String = UUID().uuidString
    var timestamp: Date
    var date: String
    var waterAmount = 0.0
    var coffeeAmount = 0.0
    var sodaAmount = 0.0
    
    init(
        timestamp: Date,
        id: String = UUID().uuidString
    ) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        self.id = id
        self.timestamp = timestamp

        self.id = id
        self.date = formatter.string(from: timestamp)
    }
    
    func addDrink(amount: Double, type: DrinkType) -> Void {
        switch type {
        case .coffee:
            self.coffeeAmount += amount
        case .water:
            self.waterAmount += amount
        case .soda:
            self.sodaAmount += amount
        }
    }
}
