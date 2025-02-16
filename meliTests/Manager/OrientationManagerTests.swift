//
//  OrientationManagerTests.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//


import XCTest
@testable import meli

class OrientationManagerTests: XCTestCase {
    func testUpdateOrientation() {
        let orientationManager = OrientationManager()

        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        orientationManager.updateOrientation()
        
        DispatchQueue.main.async {
            XCTAssertTrue(orientationManager.isLandscape)
        }

        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        orientationManager.updateOrientation()

        DispatchQueue.main.async {
            XCTAssertFalse(orientationManager.isLandscape)
        }
    }
}
