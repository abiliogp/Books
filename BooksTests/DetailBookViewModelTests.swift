//
//  DetailBookViewModelTests.swift
//  BooksTests
//
//  Created by Abilio Gambim Parada on 06/05/2024.
//

import XCTest
@testable import Books

final class DetailBookViewModelTests: XCTestCase {
    func test_book_properties() {
        let book = ListBooks.makeListBooks().result.results.first!
        
        let viewModel = DetailBookViewModel(book: book)
        
        XCTAssertEqual(viewModel.book.title, "Sample Book")
        XCTAssertEqual(viewModel.book.downloadCount, 100)
    }
}
