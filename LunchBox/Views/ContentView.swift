//
//  ContentView.swift
//  LunchBox
//
//  Created by Dan Hart on 12/4/24.
//

import SwiftUI

/// The main view displaying the menu of lunch items.
struct ContentView<ViewModel>: View where ViewModel: OrderViewModeling {
    /// Access to the shared `OrderViewModel`.
    @EnvironmentObject var orderViewModel: ViewModel
    
    /// List of available menu items.
    @State private var menuItems: [MenuItem] = []
    
    /// Controls the display of the order summary sheet.
    @State private var showOrderSummary: Bool = false

    var body: some View {
        NavigationStack {
            /// Displays the list of menu items.
            List(menuItems) { item in
                NavigationLink(destination: ItemDetailView<ViewModel>(item: item)) {
                    MenuItemView(item: item)
                }
            }
            .navigationTitle("LunchBox Menu")
            .toolbar {
                /// Toolbar button to show the order summary.
                ToolbarItem {
                    Button(action: {
                        withAnimation {
                            showOrderSummary.toggle()
                        }
                    }) {
                        ZStack {
                            Image(systemName: "cart")
                            
                            // Quantity badge
                            if orderViewModel.orderedItems.count > 0 {
                                Text("\(orderViewModel.orderedItems.count)")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .background(Color.accentColor)
                                    .clipShape(Circle())
                                    .frame(width: 15, height: 15)
                                    .offset(x: 5, y: -5)
                                    .padding()

                            }
                        }
                    }
                }
            }
        }
        /// Loads the menu items asynchronously when the view appears.
        .task {
            await loadMenuItems()
        }
        /// Presents the order summary as a sheet.
        .sheet(isPresented: $showOrderSummary) {
            OrderSummaryView<ViewModel>()
        }
        .alert("Order Placed", isPresented: $orderViewModel.showAlert) {
            Button("OK") {
                orderViewModel.clearOrder()
            }
        } message: {
            Text("Enjoy your meal!")
        }
    }

    /// Asynchronously loads menu items.
    @MainActor
    func loadMenuItems() async {
        // Simulate async data fetching
        menuItems = await orderViewModel.fetchMenuItems()
    }
}

#Preview {
    ContentView<MockOrderViewModel>()
        .environmentObject(MockOrderViewModel())
}
