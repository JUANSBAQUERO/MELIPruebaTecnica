//
//  APIClientTests.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import XCTest
@testable import meli

class APIClientTests: XCTestCase {
    
    struct MockData: Codable, Equatable {
        let id: String
        let name: String
    }
    
    func testFetch_Success() {
        let url = URL(string: "https://example.com/mockdata")!
        let mockResponse = MockData(id: "123", name: "Test Product")
        let mockJSON = """
        {
            "id": "123",
            "name": "Test Product"
        }
        """.data(using: .utf8)!
        
        let urlSessionMock = URLSessionMock(data: mockJSON, response: nil, error: nil)
        let expectation = self.expectation(description: "Completion handler invoked")
        
        urlSessionMock.fetch(url: url) { (result: Result<MockData, Error>) in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, mockResponse)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFetch_Failure() {
        let url = URL(string: "https://example.com/mockdata")!
        let mockError = NSError(domain: "TestError", code: 404, userInfo: nil)
        
        let urlSessionMock = URLSessionMock(data: nil, response: nil, error: mockError)
        let expectation = self.expectation(description: "Completion handler invoked")
        
        urlSessionMock.fetch(url: url) { (result: Result<MockData, Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, mockError.localizedDescription)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}

class URLSessionMock {
    private let mockData: Data?
    private let mockResponse: URLResponse?
    private let mockError: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.mockData = data
        self.mockResponse = response
        self.mockError = error
    }
    
    func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.global().async {
            if let error = self.mockError {
                completion(.failure(error))
            } else if let data = self.mockData {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
