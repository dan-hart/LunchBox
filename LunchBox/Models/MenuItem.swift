//
//  MenuItem.swift
//  LunchBox
//
//  Created by Dan Hart on 12/4/24.
//

import Foundation

/// Represents a menu item in the LunchBox app.
struct MenuItem: Identifiable, Codable {
    /// Unique identifier for the menu item.
    var id = UUID()
    
    /// Name of the menu item.
    let name: String
    
    /// Description of the menu item.
    let description: String
    
    /// Price of the menu item.
    let price: Double
    
    /// Emoji representation of the menu item.
    let emoji: String
}

#if DEBUG
extension MenuItem {
    static var previewItems: [MenuItem] {
        [
            previewBurger,
            previewSalad,
            previewPizza,
        ]
    }
    
    static var previewBurger: MenuItem {
        MenuItem(
            name: "Classic Burger",
            description: "A juicy beef burger with lettuce, tomato, and cheese.",
            price: 8.99,
            emoji: "🍔"
        )
    }
    
    static var previewSalad: MenuItem {
        MenuItem(
            name: "Garden Salad",
            description: "A fresh salad with mixed greens, tomatoes, and cucumbers.",
            price: 5.99,
            emoji: "🥗"
        )
    }
    
    static var previewPizza: MenuItem {
        MenuItem(
            name: "Pepperoni Pizza",
            description: "A classic pizza with pepperoni and mozzarella cheese.",
            price: 10.99,
            emoji: "🍕"
        )
    }
}
#endif
