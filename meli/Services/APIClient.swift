//
//  APIClient.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import Foundation

class APIClient {
    static func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let error as DecodingError {
                switch error {
                case .typeMismatch(let type, let context):
                    print("Type mismatch error: Expected type \(type), but found \(context.debugDescription).")
                case .valueNotFound(let value, let context):
                    print("Value not found for type \(value): \(context.debugDescription)")
                case .keyNotFound(let key, let context):
                    print("Key \(key) not found: \(context.debugDescription)")
                case .dataCorrupted(let context):
                    print("Data corrupted: \(context.debugDescription)")
                @unknown default:
                    print("Unknown decoding error: \(error.localizedDescription)")
                }
                completion(.failure(error))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
