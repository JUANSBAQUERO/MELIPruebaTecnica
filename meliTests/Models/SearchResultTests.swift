//
//  SearchResultTests.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import XCTest
@testable import meli

class SearchResultTests: XCTestCase {

    func testSearchResultDecoding() throws {
        let json = """
        {
            "results": [
                {
                    "id": "123",
                    "title": "iPhone 15",
                    "price": 999.99,
                    "thumbnail": "https://example.com/image.jpg"
                },
                {
                    "id": "456",
                    "title": "MacBook Pro",
                    "price": 1999.99,
                    "thumbnail": "https://example.com/macbook.jpg"
                }
            ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let searchResult = try decoder.decode(SearchResult.self, from: json)
        
        XCTAssertEqual(searchResult.results.count, 2)
        XCTAssertEqual(searchResult.results.first?.id, "123")
        XCTAssertEqual(searchResult.results.first?.title, "iPhone 15")
    }

    func testSearchResultEncoding() throws {
        let products = [
            Product(id: "123", title: "iPhone 15", price: 999.99, thumbnail: "https://example.com/image.jpg"),
            Product(id: "456", title: "MacBook Pro", price: 1999.99, thumbnail: "https://example.com/macbook.jpg")
        ]
        
        let searchResult = SearchResult(results: products)
        let encoder = JSONEncoder()
        let data = try encoder.encode(searchResult)
        
        let decoder = JSONDecoder()
        let decodedSearchResult = try decoder.decode(SearchResult.self, from: data)
        
        XCTAssertEqual(decodedSearchResult.results.count, 2)
        XCTAssertEqual(decodedSearchResult.results[0].id, "123")
        XCTAssertEqual(decodedSearchResult.results[0].title, "iPhone 15")
        XCTAssertEqual(decodedSearchResult.results[0].price, 999.99)
        XCTAssertEqual(decodedSearchResult.results[0].thumbnail, "https://example.com/image.jpg")
        XCTAssertEqual(decodedSearchResult.results[1].id, "456")
        XCTAssertEqual(decodedSearchResult.results[1].title, "MacBook Pro")
        XCTAssertEqual(decodedSearchResult.results[1].price, 1999.99)
        XCTAssertEqual(decodedSearchResult.results[1].thumbnail, "https://example.com/macbook.jpg")
    }

}
