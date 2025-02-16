//
//  MeliServiceTests.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import XCTest
@testable import meli

class MeliServiceTests: XCTestCase {

    func testSearchProducts_Success() {
        let query = "iPhone"
        _ = SearchResult(results: [Product(id: "123", title: "iPhone 13", price: 999.99, thumbnail: "https://image.com/iphone.jpg")])
        let mockJSON = """
        {
            "results": [
                {
                    "id": "123",
                    "title": "iPhone 13",
                    "price": 999.99,
                    "thumbnail": "https://image.com/iphone.jpg"
                }
            ]
        }
        """.data(using: .utf8)!
        
        let urlSessionMock = URLSessionMock(data: mockJSON, response: nil, error: nil)
        let expectation = self.expectation(description: "Completion handler invoked")

        let service = MeliService()
        
        urlSessionMock.fetch(url: URL(string: "\(service.url)search?q=\(query)")!) { (result: Result<SearchResult, Error>) in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.results.count, 1)
                XCTAssertEqual(data.results.first?.title, "iPhone 13")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testSearchProducts_Failure() {
        let query = "iPhone"
        let mockError = NSError(domain: "TestError", code: 404, userInfo: nil)
        
        let urlSessionMock = URLSessionMock(data: nil, response: nil, error: mockError)
        let expectation = self.expectation(description: "Completion handler invoked")

        let service = MeliService()
        
        urlSessionMock.fetch(url: URL(string: "\(service.url)search?q=\(query)")!) { (result: Result<SearchResult, Error>) in
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
