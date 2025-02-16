import SwiftUI
import Combine

class OrientationManager: ObservableObject {
    @Published var orientation = UIDevice.current.orientation
}
