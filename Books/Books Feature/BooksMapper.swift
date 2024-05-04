//
//  BooksMapper.swift
//  Books
//
//  Created by Abilio Gambim Parada on 04/05/2024.
//

import Foundation


enum BooksMapper {
    static func map(_ data: Data) async throws -> ListBooks {
        guard let books = try? JSONDecoder().decode(ListBooks.self, from: data) else {
             throw RemoteBooksLoader.Error.invalidData
        }

        return books
    }
}
