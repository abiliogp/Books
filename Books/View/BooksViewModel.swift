//
//  BooksViewModel.swift
//  Books
//
//  Created by Abilio Gambim Parada on 05/05/2024.
//

import SwiftUI

class BooksViewModel: ObservableObject {
    enum Status {
        case loading
        case ready([Book])
        case error(Error)
    }
    
    @Published var status: Status = .loading
    private let remoteBookLoader: BooksLoader
    
    init(remoteBookLoader: BooksLoader) {
        self.remoteBookLoader = remoteBookLoader
    }
    
    @MainActor
    func load() {
        Task {
            do {
                status = .loading
                let list = try await remoteBookLoader.load()
                status = .ready(list.results)
            } catch {
                status = .error(error)
            }
        }
    }
}
