//
//  RemoteBooksLoader.swift
//  Books
//
//  Created by Abilio Gambim Parada on 04/05/2024.
//

import Foundation

public protocol BooksLoader {
    func load() async throws -> ListBooks
}

public final class RemoteBooksLoader {
    private let client: HTTPClient

    public enum Error: Swift.Error {
        case invalidData
        case invalidURL
        case other
    }
    
    private enum Endpoint: String {
        case get = "https://gutendex.com/books"
    }

    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func load() async throws -> ListBooks {
        guard let url = URL(string: Endpoint.get.rawValue) else {
            throw Error.invalidURL
        }
        let data = try await client.get(from: url)
        return try await BooksMapper.map(data)
    }
}
