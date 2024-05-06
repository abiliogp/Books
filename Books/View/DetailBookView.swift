//
//  DetailBookView.swift
//  Books
//
//  Created by Abilio Gambim Parada on 04/05/2024.
//

import SwiftUI

struct DetailBookView: View {
    @ObservedObject var viewModel: DetailBookViewModel
    @ObservedObject var favoriteState: FavoriteState
    
    var body: some View {
        ScrollView {
            VStack {
                ImageLoaderView(urlString: viewModel.book.formats.imageJPEG)
                    .frame(height: 200)
                    .padding()
                
                Divider()
                
                HStack {
                    FavoriteView(favoriteState: favoriteState, bookId: viewModel.book.id)
                }
                
                Divider()
                
                VStack(alignment: .leading)  {
                    Text("Authors")
                        .font(.caption)
                    
                    ForEach(viewModel.book.authors, id: \.name) { author in
                        Text(author.name)
                            .font(.caption)
                            .lineLimit(nil)
                        
                        if let birthYear = author.birthYear {
                            Text("Birth Year: \(birthYear)")
                                .font(.caption)
                        }
                        
                        if let deathYear = author.deathYear {
                            Text("Death Year: \(deathYear)")
                                .font(.caption)
                        }
                    }
                    
                    Divider()
                    
                    Text("Subjects")
                        .font(.caption)
                    
                    ForEach(viewModel.book.subjects, id: \.self) { subject in
                        Text(subject)
                            .font(.caption)
                            .lineLimit(nil)
                    }
                    
                    Divider()
                    
                    if !viewModel.book.bookshelves.isEmpty {
                        Text("Bookshelves")
                            .font(.caption)
                        
                        ForEach(viewModel.book.bookshelves, id: \.self) { bookshelve in
                            Text(bookshelve)
                                .font(.caption)
                                .lineLimit(nil)
                        }
                        
                        Divider()
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .padding(16)
        }
        .navigationTitle(viewModel.book.title)
    }
}

#Preview {
    let response = ListBooks.makeListBooks()
    let viewModel = DetailBookViewModel(book: response.result.results.first!)
    return DetailBookView(viewModel: viewModel, favoriteState: .init(userDefaults: MockUserDefaults()))
}
