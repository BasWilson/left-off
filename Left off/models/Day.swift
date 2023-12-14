//
//  Day.swift
//  Left off
//
//  Created by Bas Wilson on 11/12/2023.
//

import Foundation
import SwiftData

@Model
final class Day: Identifiable {
    
    var id: String = UUID().uuidString
    var date: String
    var note1: String
    var note2: String
    
    init(timestamp: Date, note1: String, note2: String, id: String = UUID().uuidString) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        self.id = id
        self.date = formatter.string(from: timestamp)
        self.note1 = note1
        self.note2 = note2
    }
}
