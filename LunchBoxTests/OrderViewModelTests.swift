//
//  OrderViewModelTests.swift
//  LunchBoxTests
//
//  Created by Dan Hart on 12/4/24.
//

import Testing
@testable import LunchBox

@MainActor
struct OrderViewModelTests {
    // MARK: - Test non-mock class
    @Test func totalPriceCheck() {
        // Given
        let viewModel = OrderViewModel()
        
        // When
        viewModel.addItem(MenuItem.previewTaco)
        viewModel.addItem(MenuItem.previewBurger)
        
        // Then
        #expect(viewModel.totalPrice == 10.99)
    }
    
    // MARK: - Test using Mocks
    @Test func mockFetchMenuItems() async {
        // Given
        let viewModel = MockOrderViewModel()
        
        // When
        let menuItems = await viewModel.fetchMenuItems()
        
        // Then
        #expect(menuItems.isEmpty == false)
    }
}





