//
//  ContentView.swift
//  Books
//
//  Created by Abilio Gambim Parada on 04/05/2024.
//

import SwiftUI

struct BooksView: View {
    @ObservedObject var viewModel: BooksViewModel
    @ObservedObject var favoriteState: FavoriteState
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.status {
                case .loading:
                    loadingView
                case let .ready(list):
                    readyView(list)
                case let .error(error):
                    errorView(error)
                }
            }
            .navigationTitle("Books")
        }
    }
    
    func readyView(_ books: [Book]) -> some View {
        List {
            ForEach(books, id: \.id) { book in
                NavigationLink {
                    DetailBookView(viewModel: .init(book: book), favoriteState: favoriteState)
                } label: {
                    HStack {
                        AsyncImage(url: URL(string: book.formats.imageJPEG)!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                        .padding()
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text(book.title)
                                .font(.headline)
                            
                            Text(book.authors.first!.name)
                                .font(.caption)
                            
                            FavoriteView(favoriteState: favoriteState, bookId: book.id)
                        }
                    }
                }
            }
        }
    }
    
    var loadingView: some View {
        ProgressView("Loading...")
    }
    
    func errorView(_ error: Error) -> some View {
        Text("Error occurred: \(error.localizedDescription)")
    }
}


#Preview("Loading") {
    let viewModel = BooksViewModel(remoteBookLoader: RemoteBooksLoader(client: MockHTTPClient()))
    return BooksView(viewModel: viewModel, favoriteState: .init(userDefaults: MockUserDefaults()))
}

#Preview("Ready") {
    let response = ListBooks.makeListBooks()
    let client = MockHTTPClient()
    client.responseData = response.data
    let remoteBooksLoader = RemoteBooksLoader(client: client)
    let viewModel = BooksViewModel(remoteBookLoader: remoteBooksLoader)
    viewModel.load()
    return BooksView(viewModel: viewModel, favoriteState: .init(userDefaults: MockUserDefaults()))
}

#Preview("Error") {
    let response = ListBooks.makeListBooks()
    let client = MockHTTPClient()
    client.error = NSError(domain: "Test", code: 404, userInfo: nil)
    let remoteBooksLoader = RemoteBooksLoader(client: client)
    let viewModel = BooksViewModel(remoteBookLoader: remoteBooksLoader)
    viewModel.load()
    return BooksView(viewModel: viewModel, favoriteState: .init(userDefaults: MockUserDefaults()))
}
