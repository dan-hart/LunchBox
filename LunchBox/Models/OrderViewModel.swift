//
//  OrderViewModel.swift
//  LunchBox
//
//  Created by Dan Hart on 12/4/24.
//

import SwiftUI

@MainActor
protocol OrderViewModeling: ObservableObject {
    var orderedItems: [MenuItem] { get }
    var totalPrice: Double { get }
    var showAlert: Bool { get set }
    
    func fetchMenuItems() async -> [MenuItem]
    func addItem(_ item: MenuItem)
    func removeItem(_ item: MenuItem)
    func clearOrder()
    func placeOrder()
}

/// ViewModel managing the user's current order.
class OrderViewModel: OrderViewModeling {
    /// List of items added to the order.
    @Published var orderedItems: [MenuItem] = []
    
    /// Total price of the current order.
    @Published var totalPrice: Double = 0.0
    
    /// Show place order success or failure alert
    @Published var showAlert: Bool = false
    
    func fetchMenuItems() async -> [MenuItem] {
        // TODO: Fetch menu items from a remote server
        MenuItem.previewItems
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

#if DEBUG
class MockOrderViewModel: OrderViewModeling {
    let orderedItems: [MenuItem] = [
        MenuItem.previewTaco,
        MenuItem.previewPizza,
        MenuItem.previewBurger,
    ]
    
    var totalPrice: Double {
        orderedItems.reduce(0.0) { $0 + $1.price }
    }
    
    var showAlert: Bool = false
    
    func fetchMenuItems() async -> [MenuItem] {
        MenuItem.previewItems
    }
    
    func addItem(_ item: MenuItem) {
        // No-op
    }
    
    func removeItem(_ item: MenuItem) {
        // No-op
    }
    
    func clearOrder() {
        // No-op
    }
    
    func placeOrder() {
        // No-op
    }
}
#endif
