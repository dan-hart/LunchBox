//
//  OrderSummaryViewTests.swift
//  LunchBoxTests
//
//  Created by Dan Hart on 12/11/24.
//

import Testing
@testable import LunchBox
import ViewInspector

@MainActor
struct OrderSummaryViewTests {
    @Test func placeOrderButtonIsDisabled() throws {
        // Given
        let viewModel = MockOrderViewModel()
        viewModel.orderedItems = []
        let view = OrderSummaryView<MockOrderViewModel>()
            .environmentObject(viewModel)
        
        // When
        let button = try view.inspect().find(button: "Place Order")
        
        // Then
        #expect(button.isDisabled() == true)
    }
}
