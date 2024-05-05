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
    
    init(responseData: Data? = nil, error: Error? = nil) {
        self.responseData = responseData
        self.error = error
    }

    func get(from url: URL) async throws -> Data {
        guard let responseData = responseData else {
            throw error ?? RemoteBooksLoader.Error.other
        }
        return responseData
    }
}
