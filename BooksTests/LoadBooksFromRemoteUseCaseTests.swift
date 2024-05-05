//
//  LoadBooksFromRemoteUseCaseTests.swift
//  BooksTests
//
//  Created by Abilio Gambim Parada on 04/05/2024.
//

import XCTest
@testable import Books


final class LoadBooksFromRemoteUseCaseTests: XCTestCase {
    func test_load_throwsWithInvalidJSON() async {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: HTTPResult(error: RemoteBooksLoader.Error.invalidData, data: nil)) {
            let invalidJSON = Data("invalid json".utf8)
            client.responseData = invalidJSON
        }
    }
    
    func test_load_success() async {
        let (sut, client) = makeSUT()
        let result = ListBooks.makeListBooks()
        
        expect(sut, toCompleteWith: HTTPResult(error: nil, data: result.data)) {
            client.responseData = result.data
        }
    }
    
    
}

private extension LoadBooksFromRemoteUseCaseTests {
    func expect(_ sut: RemoteBooksLoader, toCompleteWith: HTTPResult, action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        Task {
            do {
                let result = try await sut.load()
                XCTAssertNotNil(result)
            } catch {
                XCTAssertEqual(error.localizedDescription, RemoteBooksLoader.Error.invalidData.localizedDescription)
            }
        }
        action()
    }
}
