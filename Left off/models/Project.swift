//
//  Item.swift
//  Left off
//
//  Created by Bas Wilson on 11/12/2023.
//

import Foundation
import SwiftData


@Model
final class Project: Identifiable {
    
    var id: String = UUID().uuidString
    var days: [Day]
    var name: String
    var lastUpdated: Int
    
    init(name: String, id: String = UUID().uuidString) {
        self.id = id
        self.name = name
        self.lastUpdated = Date().hashValue
        self.days = []
    }
    
    func addDay(note1: String, note2: String) {
        self.days.append(Day(timestamp: Date(), note1: note1, note2: note2))
        self.lastUpdated = Date().hashValue
    }
}
