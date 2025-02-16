//
//  ProductTests.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import XCTest
@testable import meli

class ProductTests: XCTestCase {

    func testProductInitialization() {
        let product = Product(id: "123", title: "iPhone 15", price: 999.99, thumbnail: "https://example.com/image.jpg")
        
        XCTAssertEqual(product.id, "123")
        XCTAssertEqual(product.title, "iPhone 15")
        XCTAssertEqual(product.price, 999.99)
        XCTAssertEqual(product.thumbnail, "https://example.com/image.jpg")
    }

    func testProductDecoding() throws {
        let json = """
        {
            "id": "123",
            "title": "MacBook Pro",
            "price": 1999.99,
            "thumbnail": "https://example.com/macbook.jpg"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let product = try decoder.decode(Product.self, from: json)
        
        XCTAssertEqual(product.id, "123")
        XCTAssertEqual(product.title, "MacBook Pro")
        XCTAssertEqual(product.price, 1999.99)
        XCTAssertEqual(product.thumbnail, "https://example.com/macbook.jpg")
    }

    func testProductEncoding() throws {
        let product = Product(id: "456", title: "iPad Air", price: 599.99, thumbnail: "https://example.com/ipad.jpg")
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(product)
        
        let decoder = JSONDecoder()
        let decodedProduct = try decoder.decode(Product.self, from: data)
        
        XCTAssertEqual(decodedProduct.id, "456")
        XCTAssertEqual(decodedProduct.title, "iPad Air")
        XCTAssertEqual(decodedProduct.price, 599.99)
        XCTAssertEqual(decodedProduct.thumbnail, "https://example.com/ipad.jpg")
    }

}
