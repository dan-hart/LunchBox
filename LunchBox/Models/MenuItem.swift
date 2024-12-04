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
