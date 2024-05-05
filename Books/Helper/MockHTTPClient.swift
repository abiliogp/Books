//
//  MockHTTPClient.swift
//  Books
//
//  Created by Abilio Gambim Parada on 04/05/2024.
//

import Foundation

class MockHTTPClient: HTTPClient {
    var responseData: Data?
    var error: Error?

    func get(from url: URL) async throws -> Data {
        guard let responseData = responseData else {
            throw error ?? RemoteBooksLoader.Error.other
        }
        return responseData
    }
}
