//
//  MeliService.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import Foundation

protocol MeliServiceProtocol {
    func searchProducts(query: String, completion: @escaping (Result<SearchResult, Error>) -> Void)
}

class MeliService: MeliServiceProtocol {
    private let https = Environment.https
    private let baseURL = Environment.baseURL
    private let user = Environment.user
    var url: String {
        return "\(https)/\(baseURL)/\(user)/"
    }
    
    func searchProducts(query: String, completion: @escaping (Result<SearchResult, Error>) -> Void) {
        guard let url = URL(string: "\(url)search?q=\(query)") else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }

        APIClient.fetch(url: url, completion: completion)
    }
}
