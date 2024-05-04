//
//  HTTPClientSpy.swift
//  BooksTests
//
//  Created by Abilio Gambim Parada on 04/05/2024.
//

import Foundation
import XCTest
@testable import Books

struct HTTPResult {
    var error: Error? = nil
    var data: Data? = nil
}

class HTTPClientSpy: HTTPClient {
    private var messages = [(url: URL, completion: (HTTPResult))]()

    var requestedURLs: [URL] = []
    var result = HTTPResult()
    
    func get(from url: URL) async throws -> Data {
        requestedURLs.append(url)
        guard let data = result.data else {
            throw result.error ?? RemoteBooksLoader.Error.other
        }
        return data
    }
}
