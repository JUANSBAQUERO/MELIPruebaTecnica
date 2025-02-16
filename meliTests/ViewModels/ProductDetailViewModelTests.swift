//
//  ProductDetailViewModelTests.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import XCTest
@testable import meli

class ProductDetailViewModelTests: XCTestCase {
    
    func testInit_WithProduct_SetsProduct() {
        let product = Product(id: "1", title: "Test Product", price: 999.99, thumbnail: "https://example.com/image.jpg")
        
        let viewModel = ProductDetailViewModel(product: product)
        
        XCTAssertEqual(viewModel.product.id, "1", "El ID del producto debería ser 1")
        XCTAssertEqual(viewModel.product.title, "Test Product", "El título del producto no coincide")
        XCTAssertEqual(viewModel.product.price, 999.99, "El precio del producto no coincide")
        XCTAssertEqual(viewModel.product.thumbnail, "https://example.com/image.jpg", "La URL de la imagen no coincide")
    }
}
