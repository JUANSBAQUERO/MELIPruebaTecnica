//
//  Environment.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//


import Foundation

struct Environment {
    static var https: String {
        return Bundle.main.object(forInfoDictionaryKey: "Https") as? String ?? ""
    }
    
    static var baseURL: String {
        return Bundle.main.object(forInfoDictionaryKey: "Base_url") as? String ?? ""
    }
    
    static var user: String {
        return Bundle.main.object(forInfoDictionaryKey: "User") as? String ?? ""
    }
}
