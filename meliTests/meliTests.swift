//
//  meliTests.swift
//  meliTests
//
//  Created by Juan  on 14/02/25.
//

import XCTest
@testable import meli

class meliTests: XCTestCase {

    func testSearchViewInitialization() {
        let searchView = SearchView()

        XCTAssertNotNil(searchView)
    }
}


