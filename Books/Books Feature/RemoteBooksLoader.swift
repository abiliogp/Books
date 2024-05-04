//
//  RemoteBooksLoader.swift
//  Books
//
//  Created by Abilio Gambim Parada on 04/05/2024.
//

import Foundation

public final class RemoteBooksLoader {
    private let url: URL
    private let client: HTTPClient

    public enum Error: Swift.Error {
        case invalidData
        case other
    }

    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load() async throws -> ListBooks {
        let data = try await client.get(from: url)
        return try await BooksMapper.map(data)
    }
}
