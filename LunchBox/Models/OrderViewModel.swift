//
//  OrderViewModel.swift
//  LunchBox
//
//  Created by Dan Hart on 12/4/24.
//

import SwiftUI

/// ViewModel managing the user's current order.
@MainActor
class OrderViewModel: ObservableObject {
    /// List of items added to the order.
    @Published var orderedItems: [MenuItem] = []
    
    /// Total price of the current order.
    @Published var totalPrice: Double = 0.0
    
    /// Show place order success or failure alert
    @Published var showAlert: Bool = false
    
    func fetchMenuItems() async -> [MenuItem] {
        #if DEBUG
        MenuItem.previewItems
        #else
        // TODO: Fetch menu items from a remote server
        []
        #endif
    }

    /// Adds an item to the order and updates the total price.
    /// - Parameter item: The `MenuItem` to add.
    func addItem(_ item: MenuItem) {
        orderedItems.append(item)
        totalPrice += item.price
    }

    /// Removes an item from the order and updates the total price.
    /// - Parameter item: The `MenuItem` to remove.
    func removeItem(_ item: MenuItem) {
        if let index = orderedItems.firstIndex(where: { $0.id == item.id }) {
            orderedItems.remove(at: index)
            totalPrice -= item.price
        }
    }

    /// Clears all items from the order and resets the total price.
    func clearOrder() {
        orderedItems.removeAll()
        totalPrice = 0.0
    }
    
    /// Places the current order and displays an alert.
    func placeOrder() {
        // TODO: Implement order placement logic
        showAlert = true
    }
}
