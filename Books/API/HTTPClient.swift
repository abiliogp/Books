//
//  HTTPClient.swift
//  Books
//
//  Created by Abilio Gambim Parada on 04/05/2024.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL) async throws -> Data
}
