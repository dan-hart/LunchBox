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
    @Test func addItemCheck() {
        // Given
        let viewModel = OrderViewModel()
        
        // When
        viewModel.addItem(MenuItem.previewTaco)
        
        // Then
        #expect(viewModel.orderedItems.count == 1)
    }
    
    @Test func removeItemCheck() {
        // Given
        let viewModel = OrderViewModel()
        
        // When
        viewModel.addItem(MenuItem.previewTaco)
        viewModel.removeItem(MenuItem.previewTaco)
        
        // Then
        #expect(viewModel.orderedItems.isEmpty)
    }
    
    @Test func clearOrderCheck() {
        // Given
        let viewModel = OrderViewModel()
        
        // When
        viewModel.addItem(MenuItem.previewTaco)
        viewModel.addItem(MenuItem.previewBurger)
        viewModel.clearOrder()
        
        // Then
        #expect(viewModel.orderedItems.isEmpty)
    }
    
    @Test func placeOrderCheck() {
        // Given
        let viewModel = OrderViewModel()
        
        // When
        viewModel.addItem(MenuItem.previewTaco)
        viewModel.addItem(MenuItem.previewBurger)
        viewModel.placeOrder()
        
        // Then
        #expect(viewModel.orderedItems.isEmpty)
        #expect(viewModel.totalPrice == 0.0)
        #expect(viewModel.showAlert)
    }
    
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
    @Test func mockAddItemCheck() {
        // Given
        let viewModel = MockOrderViewModel()
        viewModel.clearOrder()
        
        // When
        viewModel.addItem(MenuItem.previewTaco)
        
        // Then
        #expect(viewModel.orderedItems.count == 1)
    }
    
    @Test func mockRemoveItemCheck() {
        // Given
        let viewModel = MockOrderViewModel()
        viewModel.clearOrder()
        
        // When
        viewModel.addItem(MenuItem.previewTaco)
        viewModel.removeItem(MenuItem.previewTaco)
        
        // Then
        #expect(viewModel.orderedItems.isEmpty)
    }
    
    @Test func mockClearOrderCheck() {
        // Given
        let viewModel = MockOrderViewModel()
        viewModel.clearOrder()
        
        // When
        viewModel.addItem(MenuItem.previewTaco)
        viewModel.addItem(MenuItem.previewBurger)
        viewModel.clearOrder()
        
        // Then
        #expect(viewModel.orderedItems.isEmpty)
    }
    
    @Test func mockPlaceOrderCheck() {
        // Given
        let viewModel = MockOrderViewModel()
        viewModel.clearOrder()
        
        // When
        viewModel.addItem(MenuItem.previewTaco)
        viewModel.addItem(MenuItem.previewBurger)
        viewModel.placeOrder()
        
        // Then
        #expect(viewModel.orderedItems.isEmpty)
        #expect(viewModel.totalPrice == 0.0)
        #expect(viewModel.showAlert)
    }
    
    @Test func mockFetchMenuItems() async {
        // Given
        let viewModel = MockOrderViewModel()
        
        // When
        let menuItems = await viewModel.fetchMenuItems()
        
        // Then
        #expect(menuItems.isEmpty == false)
    }
}





