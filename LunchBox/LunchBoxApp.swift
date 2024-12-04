//
//  LunchBoxApp.swift
//  LunchBox
//
//  Created by Dan Hart on 12/4/24.
//

import SwiftUI

@main
struct LunchBoxApp: App {
    /// Shared instance of `OrderViewModel` for the app.
        @StateObject private var orderViewModel = OrderViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(orderViewModel)
        }
    }
}
