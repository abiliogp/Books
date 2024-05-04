//
//  LoadBooksFromRemoteUseCaseTests.swift
//  BooksTests
//
//  Created by Abilio Gambim Parada on 04/05/2024.
//

import XCTest
@testable import Books

final class LoadBooksFromRemoteUseCaseTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()

        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_throwsWithInvalidJSON() async {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: HTTPResult(error: RemoteBooksLoader.Error.invalidData, data: nil)) {
            let invalidJSON = Data("invalid json".utf8)
            client.result.data = invalidJSON
        }
    }
    
    func test_load_success() async {
        let (sut, client) = makeSUT()
        let result = makeListBooks()

        expect(sut, toCompleteWith: HTTPResult(error: nil, data: result.data)) {
            client.result.data = result.data
        }
    }
    
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
    
    private func makeSUT(url: URL = URL(string: "https://example.com/")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteBooksLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteBooksLoader(url: url, client: client)
        return (sut, client)
    }
    
    private func makeListBooks() -> (data: Data, result: ListBooks) {
        let anyURLStr = "https://example.com/sample_book.html"
        
        let book = Book(id: 123,
                        title: "Sample Book",
                        authors: [Author(name: "John Doe", birthYear: 1900, deathYear: nil)],
                        translators: [],
                        subjects: ["Fiction"],
                        bookshelves: ["Bestsellers"],
                        languages: [.en],
                        copyright: true,
                        mediaType: .text,
                        formats: Formats(textHTML: anyURLStr,
                                         applicationEpubZip: anyURLStr,
                                         applicationXMobipocketEbook: anyURLStr,
                                         applicationRDFXML: anyURLStr,
                                         imageJPEG: anyURLStr,
                                         textPlainCharsetUsASCII: anyURLStr,
                                         applicationOctetStream: anyURLStr,
                                         textHTMLCharsetUTF8: anyURLStr,
                                         textPlainCharsetUTF8: anyURLStr,
                                         textPlainCharsetISO88591: anyURLStr,
                                         textHTMLCharsetISO88591: anyURLStr),
                        downloadCount: 100)
        
        let list = ListBooks(count: 1,
                             next: "",
                             previous: nil,
                             results: [book])
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(list)
        
        return (data, list)
    }

}
