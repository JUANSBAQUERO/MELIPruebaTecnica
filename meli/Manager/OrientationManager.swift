//
//  OrientationManager.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import SwiftUI
import Combine

class OrientationManager: ObservableObject {
    @Published var isLandscape: Bool = UIDevice.current.orientation.isLandscape

    func updateOrientation() {
        DispatchQueue.main.async {
            self.isLandscape = UIDevice.current.orientation.isLandscape
        }
    }
}
