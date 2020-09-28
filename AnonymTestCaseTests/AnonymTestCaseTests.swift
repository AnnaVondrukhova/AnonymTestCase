//
//  AnonymTestCaseTests.swift
//  AnonymTestCaseTests
//
//  Created by Anya on 28.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import XCTest
@testable import AnonymTestCase

class AnonymTestCaseTests: XCTestCase {
    
    var sut: NetworkService!
    
    override func setUp() {
        super.setUp()
        sut = NetworkService.shared
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testValidCallToAPIReturnsStatusCode200() {
        let url = URL(string: "http://stage.apianon.ru:3000/fs-posts/v1/posts")
        
        let statusCodeExpectation = expectation(description: "Status code 200 expectation")
        var caughtStatusCode: Int?
        
        sut.getData(with: url!) { (_, statusCode) in
            caughtStatusCode = statusCode
            statusCodeExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { _ in
            XCTAssertEqual(caughtStatusCode, 200)
        }
    }
    
    func testInvalidCallToAPIReturnsStatusCodeNot200() {
        let url = URL(string: "http://stage.apianon.ru:3000/fs-posts/v1/posts0")
        
        let statusCodeExpectation = expectation(description: "Status code not 200 expectation")
        var caughtStatusCode: Int?
        
        sut.getData(with: url!) { (_, statusCode) in
            caughtStatusCode = statusCode
            statusCodeExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { _ in
            XCTAssertNotEqual(caughtStatusCode, 200)
        }
    }
    
    func testValidCallToAPIReturnsData() {
        let url = URL(string: "http://stage.apianon.ru:3000/fs-posts/v1/posts")
        
        let dataExpectation = expectation(description: "Got data expectation")
        var caughtData: Data?
        
        sut.getData(with: url!) { (data, _) in
            caughtData = data
            dataExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { _ in
            XCTAssertNotNil(caughtData)
        }
    }
    
    func testDataIsCashed() {
        let url = URL(string: "http://stage.apianon.ru:3000/fs-posts/v1/posts")
        
        let dataExpectation = expectation(description: "Data was cached expectation")
        var caughtData: Data?
        
        sut.getData(with: url!) { (data, _) in
            caughtData = data
            dataExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { _ in
            let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url!))
            XCTAssertNotNil(cachedResponse)
            XCTAssertEqual(cachedResponse?.data, caughtData)
        }
    }
    
    
    
    //запускать с отключенным интернетом
    func testNoInternetCallWithCacheReturnsData() {
        let url = URL(string: "http://stage.apianon.ru:3000/fs-posts/v1/posts")
        let fakeData = "{}".data(using: .utf8)!
        let fakeResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        sut.cacheData(data: fakeData, response: fakeResponse)
        
                
        let dataExpectation = expectation(description: "Get data from cache expectation")
        var caughtData: Data?
        
        sut.getData(with: url!) { (data, statusCode) in
            print(statusCode)
            caughtData = data
            dataExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { _ in
            XCTAssertNotNil(caughtData)
        }
    }
    
    //запускать с отключенным интернетом
    func testNoInternetCallWithoutCacheReturnsError() {
        let url = URL(string: "http://stage.apianon.ru:3000/fs-posts/v1/posts")
        let request = URLRequest(url: url!)
        URLCache.shared.removeAllCachedResponses()
        
        let statusCodeExpectation = expectation(description: "Status code \"no internet\" expectation")
        var caughtStatusCode: Int?
        
        sut.getData(with: url!) { (_, statusCode) in
            print(statusCode)
            caughtStatusCode = statusCode
            statusCodeExpectation.fulfill()
        }
        
        
        
        waitForExpectations(timeout: 5) { _ in
            XCTAssertEqual(caughtStatusCode, URLError.Code.notConnectedToInternet.rawValue)
        }
    }
}
