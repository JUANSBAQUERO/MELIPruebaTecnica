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
        let attributes = [Product.Attribute(id: "color", name: "Color", value_name: "Black")]
        let product = Product(
            id: "123",
            title: "iPhone 15",
            price: 999.99,
            category_id: "electronics",
            thumbnail: "https://example.com/image.jpg",
            permalink: "https://example.com/product",
            attributes: attributes
        )
        
        XCTAssertEqual(product.id, "123")
        XCTAssertEqual(product.title, "iPhone 15")
        XCTAssertEqual(product.price, 999.99)
        XCTAssertEqual(product.category_id, "electronics")
        XCTAssertEqual(product.thumbnail, "https://example.com/image.jpg")
        XCTAssertEqual(product.permalink, "https://example.com/product")
        XCTAssertEqual(product.attributes?.first?.id, "color")
        XCTAssertEqual(product.attributes?.first?.name, "Color")
        XCTAssertEqual(product.attributes?.first?.value_name, "Black")
    }

    func testProductDecoding() throws {
        let json = """
        {
            "id": "123",
            "title": "MacBook Pro",
            "price": 1999.99,
            "category_id": "laptops",
            "thumbnail": "https://example.com/macbook.jpg",
            "permalink": "https://example.com/macbook",
            "attributes": [
                {
                    "id": "processor",
                    "name": "Processor",
                    "value_name": "M3 Pro"
                }
            ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let product = try decoder.decode(Product.self, from: json)
        
        XCTAssertEqual(product.id, "123")
        XCTAssertEqual(product.title, "MacBook Pro")
        XCTAssertEqual(product.price, 1999.99)
        XCTAssertEqual(product.category_id, "laptops")
        XCTAssertEqual(product.thumbnail, "https://example.com/macbook.jpg")
        XCTAssertEqual(product.permalink, "https://example.com/macbook")
        XCTAssertEqual(product.attributes?.first?.id, "processor")
        XCTAssertEqual(product.attributes?.first?.name, "Processor")
        XCTAssertEqual(product.attributes?.first?.value_name, "M3 Pro")
    }

    func testProductEncoding() throws {
        let attributes = [Product.Attribute(id: "storage", name: "Storage", value_name: "256GB")]
        let product = Product(
            id: "456",
            title: "iPad Air",
            price: 599.99,
            category_id: "tablets",
            thumbnail: "https://example.com/ipad.jpg",
            permalink: "https://example.com/ipad",
            attributes: attributes
        )
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(product)
        
        let decoder = JSONDecoder()
        let decodedProduct = try decoder.decode(Product.self, from: data)
        
        XCTAssertEqual(decodedProduct.id, "456")
        XCTAssertEqual(decodedProduct.title, "iPad Air")
        XCTAssertEqual(decodedProduct.price, 599.99)
        XCTAssertEqual(decodedProduct.category_id, "tablets")
        XCTAssertEqual(decodedProduct.thumbnail, "https://example.com/ipad.jpg")
        XCTAssertEqual(decodedProduct.permalink, "https://example.com/ipad")
        XCTAssertEqual(decodedProduct.attributes?.first?.id, "storage")
        XCTAssertEqual(decodedProduct.attributes?.first?.name, "Storage")
        XCTAssertEqual(decodedProduct.attributes?.first?.value_name, "256GB")
    }
}
