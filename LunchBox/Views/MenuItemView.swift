//
//  MenuItemView.swift
//  LunchBox
//
//  Created by Dan Hart on 12/4/24.
//

import SwiftUI

/// View representing a single menu item in the list.
struct MenuItemView: View {
    /// The menu item to display.
    let item: MenuItem

    var body: some View {
        HStack {
            /// Emoji representation of the menu item.
            Text(item.emoji)
                .font(.system(size: 60))
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 5) {
                /// Name of the menu item.
                Text(item.name)
                    .font(.headline)
                
                /// Price of the menu item.
                Text("$\(item.price, specifier: "%.2f")")
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding()
        .accessibilityElement(children: .combine)
    }
}
