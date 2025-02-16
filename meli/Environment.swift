import Foundation

struct Environment {
    static var baseURL: String {
        return Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
    }
}
