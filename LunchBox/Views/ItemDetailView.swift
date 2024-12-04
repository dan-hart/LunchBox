//
//  ItemDetailView.swift
//  LunchBox
//
//  Created by Dan Hart on 12/4/24.
//

import SwiftUI

/// View displaying detailed information about a menu item.
struct ItemDetailView: View {
    /// Dismissal action for the view.
    @Environment(\.dismiss) var dismiss
    
    /// The menu item being detailed.
    let item: MenuItem
    
    /// Access to the shared `OrderViewModel`.
    @EnvironmentObject var orderViewModel: OrderViewModel
    
    /// Quantity of the item to order.
    @State private var quantity: Int = 1

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                /// Large emoji representing the menu item.
                Text(item.emoji)
                    .font(.system(size: 200))
                    .frame(height: 200)
                    .accessibilityHidden(true)

                /// Name of the menu item.
                Text(item.name)
                    .font(.largeTitle)
                    .padding(.top)

                /// Description of the menu item.
                Text(item.description)
                    .font(.body)
                    .padding(.vertical)

                /// Quantity selector.
                Stepper(value: $quantity, in: 1...10) {
                    Text("Quantity: \(quantity)")
                }
                .padding(.vertical)

                /// Button to add the item to the order.
                Button(action: addToOrder) {
                    Text("Add to Order - $\(totalPrice(), specifier: "%.2f")")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle(item.name)
    }

    /// Calculates the total price based on quantity and selected add-ons.
    /// - Returns: The total price.
    func totalPrice() -> Double {
        return (item.price) * Double(quantity)
    }

    /// Adds the item to the order.
    func addToOrder() {
        var orderedItem = item
        
        orderedItem = MenuItem(
            name: item.name,
            description: item.description,
            price: item.price,
            emoji: item.emoji
        )

        for _ in 0..<quantity {
            orderViewModel.addItem(orderedItem)
        }
        
        dismiss()
    }
}

#Preview {
    ItemDetailView(item: MenuItem.previewBurger)
}
