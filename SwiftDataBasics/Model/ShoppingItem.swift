//
//  ShoppingItem.swift
//  SwiftDataBasics
//
//  Created by Dennis on 06.06.25.
//

import SwiftUI
import SwiftData


@Model
class ShoppingItem {
    var name: String
    var isCompleted: Bool
    var category: String
    var createdAt: Date
    
    init(name: String, category: String = "Allgemein") {
        self.name = name
        self.isCompleted = false
        self.category = category
        self.createdAt = Date()
    }
}


