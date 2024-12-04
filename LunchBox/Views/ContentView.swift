//
//  ContentView.swift
//  LunchBox
//
//  Created by Dan Hart on 12/4/24.
//

import SwiftUI

/// The main view displaying the menu of lunch items.
struct ContentView: View {
    /// Access to the shared `OrderViewModel`.
    @EnvironmentObject var orderViewModel: OrderViewModel
    
    /// List of available menu items.
    @State private var menuItems: [MenuItem] = []
    
    /// Controls the display of the order summary sheet.
    @State private var showOrderSummary: Bool = false

    var body: some View {
        NavigationStack {
            /// Displays the list of menu items.
            List(menuItems) { item in
                NavigationLink(destination: ItemDetailView(item: item)) {
                    MenuItemView(item: item)
                }
            }
            .navigationTitle("LunchBox Menu")
            .toolbar {
                /// Toolbar button to show the order summary.
                ToolbarItem(placement: .navigationBarTrailing) {
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
            OrderSummaryView()
        }
    }

    /// Asynchronously loads menu items.
    @MainActor
    func loadMenuItems() async {
        // Simulate async data fetching
        menuItems = await orderViewModel.fetchMenuItems()
    }
}

