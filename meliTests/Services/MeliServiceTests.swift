//
//  MeliServiceTests.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import XCTest
@testable import meli

class MeliServiceTests: XCTestCase {

    func testSearchProducts_Success() {
        let query = "iPhone"

        let mockProduct = Product(
            id: "123",
            title: "iPhone 15",
            price: 999.99,
            category_id: "electronics",
            thumbnail: "https://example.com/image.jpg",
            permalink: "https://example.com/product",
            attributes: []
        )
        _ = SearchResult(results: [mockProduct])

        let mockJSON = """
        {
            "results": [
                {
                    "id": "123",
                    "title": "iPhone 13",
                    "price": 999.99,
                    "category_id": "MLA1055",
                    "thumbnail": "https://image.com/iphone.jpg",
                    "permalink": "https://meli.com/item/123",
                    "attributes": []
                }
            ]
        }
        """.data(using: .utf8)!
        
        let urlSessionMock = URLSessionMock(data: mockJSON, response: nil, error: nil)
        let expectation = self.expectation(description: "Completion handler invoked")

        let service = MeliService()
        
        urlSessionMock.fetch(url: URL(string: "\(service.url)search?q=\(query)")!) { (result: Result<SearchResult, Error>) in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.results.count, 1)
                XCTAssertEqual(data.results.first?.title, "iPhone 13")
                XCTAssertEqual(data.results.first?.category_id, "MLA1055")
                XCTAssertEqual(data.results.first?.permalink, "https://meli.com/item/123")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testSearchProducts_Failure() {
        let query = "iPhone"
        let mockError = NSError(domain: "TestError", code: 404, userInfo: nil)
        
        let urlSessionMock = URLSessionMock(data: nil, response: nil, error: mockError)
        let expectation = self.expectation(description: "Completion handler invoked")

        let service = MeliService()
        
        urlSessionMock.fetch(url: URL(string: "\(service.url)search?q=\(query)")!) { (result: Result<SearchResult, Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, mockError.localizedDescription)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testSearchProductsByCategory_Success() {
        let categoryId = "MLA1055"

        let mockProduct = Product(
            id: "123",
            title: "iPhone 15",
            price: 999.99,
            category_id: categoryId,
            thumbnail: "https://example.com/image.jpg",
            permalink: "https://example.com/product",
            attributes: []
        )
        _ = SearchResult(results: [mockProduct])

        let mockJSON = """
        {
            "results": [
                {
                    "id": "123",
                    "title": "iPhone 13",
                    "price": 999.99,
                    "category_id": "MLA1055",
                    "thumbnail": "https://image.com/iphone.jpg",
                    "permalink": "https://meli.com/item/123",
                    "attributes": []
                }
            ]
        }
        """.data(using: .utf8)!

        let urlSessionMock = URLSessionMock(data: mockJSON, response: nil, error: nil)
        let expectation = self.expectation(description: "Completion handler invoked")

        let service = MeliService()

        urlSessionMock.fetch(url: URL(string: "\(service.url)search?category=\(categoryId)")!) { (result: Result<SearchResult, Error>) in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.results.count, 1)
                XCTAssertEqual(data.results.first?.title, "iPhone 13")
                XCTAssertEqual(data.results.first?.category_id, "MLA1055")
                XCTAssertEqual(data.results.first?.permalink, "https://meli.com/item/123")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testSearchProductsByCategory_Failure() {
        let categoryId = "MLA1055"
        let mockError = NSError(domain: "TestError", code: 404, userInfo: nil)

        let urlSessionMock = URLSessionMock(data: nil, response: nil, error: mockError)
        let expectation = self.expectation(description: "Completion handler invoked")

        let service = MeliService()

        urlSessionMock.fetch(url: URL(string: "\(service.url)search?category=\(categoryId)")!) { (result: Result<SearchResult, Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, mockError.localizedDescription)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

}
