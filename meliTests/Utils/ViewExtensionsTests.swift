//
//  ViewExtensionsTests.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import XCTest
@testable import meli

class ViewExtensionsTests: XCTestCase {
    
    func testFormattedPrice() {
        let price: Double = 2500
        let formattedPrice = price.formattedPrice()
        XCTAssertEqual(formattedPrice, "$ 2.500", "El precio no está formateado correctamente")
        
        let zeroPrice: Double = 0
        XCTAssertEqual(zeroPrice.formattedPrice(), "$ 0", "El precio cero debería formatearse correctamente")
    }
}
