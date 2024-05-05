//
//  XCTestCase+Helper.swift
//  BooksTests
//
//  Created by Abilio Gambim Parada on 05/05/2024.
//

import XCTest
@testable import Books

extension XCTest {
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteBooksLoader, client: MockHTTPClient) {
        let client = MockHTTPClient()
        let sut = RemoteBooksLoader(client: client)
        return (sut, client)
    }
    
    struct HTTPResult {
        let error: Error?
        let data: Data?
    }
}
