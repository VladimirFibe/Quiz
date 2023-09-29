//
//  Item.swift
//  Quiz
//
//  Created by Vladimir Fibe on 29.09.2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
