//
//  ItemDetailViewTests.swift
//  LunchBoxTests
//
//  Created by Dan Hart on 12/11/24.
//

import Testing
@testable import LunchBox
import ViewInspector

@MainActor
struct ItemDetailViewTests {
    @Test func priceLabel() throws {
        // Given
        let item = MenuItem.previewTaco
        let viewModel = MockOrderViewModel()
        let view = ItemDetailView<MockOrderViewModel>(item: item)
            .environmentObject(viewModel)
        
        // When
        let priceLabel = try view.inspect().find(viewWithAccessibilityIdentifier: "price")
        
        // Then
        let text = try priceLabel.text().string()
        #expect(text == "Add to Order - $2.00")
    }
}
