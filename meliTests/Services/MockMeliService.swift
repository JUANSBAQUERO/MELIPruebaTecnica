//
//  MockMeliService.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import Foundation
@testable import meli

class MockMeliService: MeliServiceProtocol {
    var mockResult: Result<SearchResult, Error>?
    
    func searchProducts(query: String, completion: @escaping (Result<SearchResult, Error>) -> Void) {
        if let result = mockResult {
            completion(result)
        }
    }
    
    func searchProductsByCategory(categoryId: String, completion: @escaping (Result<SearchResult, Error>) -> Void) {
        if let result = mockResult {
            completion(result)
        }
    }
}
