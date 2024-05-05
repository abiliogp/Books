//
//  BooksViewModelTests.swift
//  BooksTests
//
//  Created by Abilio Gambim Parada on 05/05/2024.
//

import XCTest
@testable import Books

final class BooksViewModelTests: XCTestCase {
    func testLoad_NotLoad() async throws {
        let (sut, _) = makeSUT()
        let viewModel = BooksViewModel(remoteBookLoader: sut)
        
        XCTAssertEqual(viewModel.status, .loading)
    }
    
    func testLoad_Success() async throws {
        let (sut, client) = makeSUT()
        let response = ListBooks.makeListBooks()
        client.responseData = response.data
        
        expect(sut, expectStatus: .ready(response.result.results))
    }
    
    func testLoad_Failure() async throws {
        let error = NSError(domain: "Test", code: 404, userInfo: nil)
        let (sut, client) = makeSUT()
        client.error = error
        
        expect(sut, expectStatus: .error(error))
    }
}

private extension BooksViewModelTests {
    func expect(_ sut: RemoteBooksLoader, expectStatus: BooksViewModel.Status, file: StaticString = #filePath, line: UInt = #line) {
        Task {
            let viewModel = BooksViewModel(remoteBookLoader: sut)
            await viewModel.load()
            
            XCTAssertEqual(viewModel.status, expectStatus)
        }
    }
}

extension BooksViewModel.Status: Equatable {
    public static func == (lhs: BooksViewModel.Status, rhs: BooksViewModel.Status) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case let (.ready(books1), .ready(books2)):
            return books1.first?.id == books2.first?.id
        case let (.error(error1), .error(error2)):
            return "\(error1)" == "\(error2)" // Compare error descriptions for simplicity
        default:
            return false
        }
    }
}
