//
//  SearchViewModelTests.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import XCTest
@testable import meli

class SearchViewModelTests: XCTestCase {
    
    var viewModel: SearchViewModel!
    var mockService: MockMeliService!

    override func setUp() {
        super.setUp()
        mockService = MockMeliService()
        viewModel = SearchViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testSearchProducts_Success() {
        let mockProducts = [
            Product(
                id: "1",
                title: "Producto 1",
                price: 100.0,
                category_id: "MLA12345",
                thumbnail: "https://example.com/1.jpg",
                permalink: "https://example.com/product1",
                attributes: []
            ),
            Product(
                id: "2",
                title: "Producto 2",
                price: 200.0,
                category_id: "MLA67890",
                thumbnail: "https://example.com/2.jpg",
                permalink: "https://example.com/product2",
                attributes: []
            )
        ]

        let mockResult = SearchResult(results: mockProducts)
        
        mockService.mockResult = .success(mockResult)

        viewModel.searchText = "test"
        viewModel.searchProducts()
        
        XCTAssertTrue(viewModel.isLoading, "isLoading debe ser true al iniciar la búsqueda")

        DispatchQueue.main.async {
            XCTAssertFalse(self.viewModel.isLoading, "isLoading debe ser false después de obtener los resultados")
            XCTAssertEqual(self.viewModel.results.count, 2, "Debe haber 2 productos en los resultados")
            XCTAssertEqual(self.viewModel.results.first?.title, "Producto 1", "El primer producto debe ser 'Producto 1'")
        }
    }

    func testSearchProducts_Failure() {
        mockService.mockResult = .failure(NSError(domain: "TestError", code: -1, userInfo: nil))
        
        viewModel.searchText = "test"
        viewModel.searchProducts()
        
        XCTAssertTrue(viewModel.isLoading, "isLoading debe ser true al iniciar la búsqueda")

        DispatchQueue.main.async {
            XCTAssertFalse(self.viewModel.isLoading, "isLoading debe ser false después del error")
            XCTAssertTrue(self.viewModel.results.isEmpty, "Los resultados deben estar vacíos en caso de error")
        }
    }
}
