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
                    "category_id": "MLA12345",
                    "thumbnail": "https://example.com/2.jpg",
                    "permalink": "https://example.com/product2",
                    "attributes": []
                },
                {
                    "id": "456",
                    "title": "MacBook Pro",
                    "price": 1999.99,
                    "category_id": "MLA12345",
                    "thumbnail": "https://example.com/2.jpg",
                    "permalink": "https://example.com/product2",
                    "attributes": []
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
            Product(
                id: "123",
                title: "iPhone 15",
                price: 999.99,
                category_id: "MLA12345",
                thumbnail: "https://example.com/1.jpg",
                permalink: "https://example.com/product1",
                attributes: []
            ),
            Product(
                id: "456",
                title: "MacBook Pro",
                price: 1999.99,
                category_id: "MLA12345",
                thumbnail: "https://example.com/2.jpg",
                permalink: "https://example.com/product2",
                attributes: []
            )
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
        XCTAssertEqual(decodedSearchResult.results[0].category_id, "MLA12345")
        XCTAssertEqual(decodedSearchResult.results[0].thumbnail, "https://example.com/1.jpg")
        XCTAssertEqual(decodedSearchResult.results[0].permalink, "https://example.com/product1")
        XCTAssertEqual(decodedSearchResult.results[1].id, "456")
        XCTAssertEqual(decodedSearchResult.results[1].title, "MacBook Pro")
        XCTAssertEqual(decodedSearchResult.results[1].price, 1999.99)
        XCTAssertEqual(decodedSearchResult.results[1].category_id, "MLA12345")
        XCTAssertEqual(decodedSearchResult.results[1].thumbnail, "https://example.com/2.jpg")
        XCTAssertEqual(decodedSearchResult.results[1].permalink, "https://example.com/product2")
    }

}
