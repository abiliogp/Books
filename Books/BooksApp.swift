//
//  BooksApp.swift
//  Books
//
//  Created by Abilio Gambim Parada on 04/05/2024.
//

import SwiftUI

@main
struct BooksApp: App {
    
    var body: some Scene {
        WindowGroup {
            let client = RemoteHTTPClient()
            let remoteBooksLoader = RemoteBooksLoader(client: client)
            let viewModel = BooksViewModel(remoteBookLoader: remoteBooksLoader)
            BooksView(viewModel: viewModel)
        }
    }
}
