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
        let product = Product(
            id: "1",
            title: "Test Product",
            price: 999.99,
            category_id: "MLA12345",
            thumbnail: "https://example.com/image.jpg",
            permalink: "https://example.com/product1",
            attributes: [] 
        )
        
        let viewModel = ProductDetailViewModel(product: product)
        
        XCTAssertEqual(viewModel.product.id, "1", "El ID del producto debería ser 1")
        XCTAssertEqual(viewModel.product.title, "Test Product", "El título del producto no coincide")
        XCTAssertEqual(viewModel.product.price, 999.99, "El precio del producto no coincide")
        XCTAssertEqual(viewModel.product.thumbnail, "https://example.com/image.jpg", "La URL de la imagen no coincide")
    }
    
    func testFetchRecommendedProducts_Success() {
        let product = Product(
            id: "1",
            title: "Test Product",
            price: 999.99,
            category_id: "MLA12345",
            thumbnail: "https://example.com/image.jpg",
            permalink: "https://example.com/product1",
            attributes: []
        )
        
        let mockService = MockMeliService()
        let viewModel = ProductDetailViewModel(product: product, service: mockService)

        let mockProducts = [
            Product(
                id: "2",
                title: "Producto recomendado",
                price: 500.0,
                category_id: "MLA12345",
                thumbnail: "https://example.com/2.jpg",
                permalink: "https://example.com/product2",
                attributes: []
            )
        ]
        
        let mockResult = SearchResult(results: mockProducts)
        mockService.mockResult = .success(mockResult)

        viewModel.fetchRecommendedProducts()

        DispatchQueue.main.async {
            XCTAssertFalse(viewModel.isLoading, "isLoading debe ser false después de obtener las recomendaciones")
            XCTAssertEqual(viewModel.recommendedProducts.count, 1, "Debe haber 1 producto recomendado en los resultados")
            XCTAssertEqual(viewModel.recommendedProducts.first?.title, "Producto recomendado", "El primer producto recomendado debe ser 'Producto recomendado'")
        }
    }

    func testFetchRecommendedProducts_Failure() {
        let product = Product(
            id: "1",
            title: "Test Product",
            price: 999.99,
            category_id: "MLA12345",
            thumbnail: "https://example.com/image.jpg",
            permalink: "https://example.com/product1",
            attributes: []
        )
        
        let mockService = MockMeliService()
        let viewModel = ProductDetailViewModel(product: product, service: mockService)

        mockService.mockResult = .failure(NSError(domain: "TestError", code: -1, userInfo: nil))

        viewModel.fetchRecommendedProducts()

        DispatchQueue.main.async {
            XCTAssertFalse(viewModel.isLoading, "isLoading debe ser false después del error")
            XCTAssertTrue(viewModel.recommendedProducts.isEmpty, "Los productos recomendados deben estar vacíos en caso de error")
        }
    }
}
