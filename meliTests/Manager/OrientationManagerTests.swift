import XCTest
@testable import meli

class OrientationManagerTests: XCTestCase {
    func testUpdateOrientation() {
        let orientationManager = OrientationManager()

        // Simular orientación en landscape
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        orientationManager.updateOrientation()
        
        // Asegurar que isLandscape sea true
        DispatchQueue.main.async {
            XCTAssertTrue(orientationManager.isLandscape)
        }

        // Simular orientación en portrait
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        orientationManager.updateOrientation()

        // Asegurar que isLandscape sea false
        DispatchQueue.main.async {
            XCTAssertFalse(orientationManager.isLandscape)
        }
    }
}
