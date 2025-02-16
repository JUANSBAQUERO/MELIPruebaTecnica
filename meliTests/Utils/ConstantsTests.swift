//
//  ConstantsTests.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import XCTest
import SwiftUI
@testable import meli

class ConstantsTests: XCTestCase {

    func testColorsExist() {
        let colors = [
            Constants.mainColor,
            Constants.meliYellow,
            Constants.meliBlue,
            Constants.meliGray
        ]
        
        for color in colors {
            XCTAssertNotNil(color, "El color no debería ser nil")
        }
    }
}
