//
//  BooksApp.swift
//  Books
//
//  Created by Abilio Gambim Parada on 04/05/2024.
//

import SwiftUI

@main
struct BooksApp: App {
    private let client: HTTPClient
    private let booksLoader: BooksLoader
    private let favoriteState: FavoriteState
    
    
    init() {
        client = RemoteHTTPClient()
        booksLoader = RemoteBooksLoader(client: client)
        favoriteState = FavoriteState()
    }

    var body: some Scene {
        WindowGroup {
            let viewModel = BooksViewModel(remoteBookLoader: booksLoader)
            BooksView(viewModel: viewModel, favoriteState: favoriteState)
                .onAppear {
                    favoriteState.load()
                }
        }
    }
}
