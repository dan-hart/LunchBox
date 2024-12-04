//
//  OrderSummaryView.swift
//  LunchBox
//
//  Created by Dan Hart on 12/4/24.
//

import SwiftUI

/// View displaying the summary of the user's order.
struct OrderSummaryView: View {
    /// Access to the shared `OrderViewModel`.
    @EnvironmentObject var orderViewModel: OrderViewModel
    
    /// Environment dismiss action to close the view.
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            /// List of items in the order.
            List {
                ForEach(orderViewModel.orderedItems) { item in
                    HStack {
                        /// Emoji representation of the item.
                        Text(item.emoji)
                            .font(.system(size: 40))
                        /// Name of the item.
                        Text(item.name)
                        Spacer()
                        /// Price of the item.
                        Text("$\(item.price, specifier: "%.2f")")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Your Order")
            .toolbar {
                /// Close button to dismiss the order summary.
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
                
                /// Edit button to enable item deletion.
                #if os(iOS)
                ToolbarItem {
                    EditButton()
                }
                #endif
            }
            
            /// Total price and place order button.
            VStack {
                Text("Total: $\(orderViewModel.totalPrice, specifier: "%.2f")")
                    .font(.title2)
                Button(action: {
                    dismiss()
                    orderViewModel.placeOrder()
                }) {
                    Text("Place Order")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(orderViewModel.orderedItems.isEmpty ? Color.gray : Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(orderViewModel.orderedItems.isEmpty)
                
                Button(action: orderViewModel.clearOrder) {
                    Text("Clear Items")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(orderViewModel.orderedItems.isEmpty ? Color.gray : Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(orderViewModel.orderedItems.isEmpty)
            }
            .padding()
        }
    }

    /// Deletes items from the order.
    /// - Parameter offsets: IndexSet of items to delete.
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = orderViewModel.orderedItems[index]
            orderViewModel.removeItem(item)
        }
    }
}

#Preview {
    @Previewable var orderViewModel = OrderViewModel()
    
    OrderSummaryView()
        .environmentObject(orderViewModel)
        .onAppear {
            orderViewModel.addItem(MenuItem.previewTaco)
        }
}
