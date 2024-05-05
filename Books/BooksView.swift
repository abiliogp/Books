//
//  ContentView.swift
//  Books
//
//  Created by Abilio Gambim Parada on 04/05/2024.
//

import SwiftUI

class BooksViewModel: ObservableObject {
    enum Status {
        case loading
        case ready([Book])
        case error(Error)
    }
    
    @Published var status: Status = .loading
    private let remoteBookLoader: RemoteBooksLoader
    
    init(remoteBookLoader: RemoteBooksLoader) {
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

struct BooksView: View {
    @ObservedObject var viewModel: BooksViewModel
    
    
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
        .onAppear {
            viewModel.load()
        }
    }
    
    func readyView(_ books: [Book]) -> some View {
        List {
            ForEach(books, id: \.id) { book in
                NavigationLink {
                    DetailBookView(viewModel: .init(book: book))
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
                            
                            Image(systemName: "heart")
                                .frame(width: 20, height: 20)
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

#Preview {
    let response = ListBooks.makeListBooks()
    let client = MockHTTPClient()
    client.responseData = response.data
    let remoteBooksLoader = RemoteBooksLoader(client: client)
    let viewModel = BooksViewModel(remoteBookLoader: remoteBooksLoader)
    return BooksView(viewModel: viewModel)
}
