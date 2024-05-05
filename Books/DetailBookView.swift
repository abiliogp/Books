//
//  DetailBookView.swift
//  Books
//
//  Created by Abilio Gambim Parada on 04/05/2024.
//

import SwiftUI

class DetailBookViewModel: ObservableObject {
    @Published var book: Book
    
    init(book: Book) {
        self.book = book
    }
}

struct DetailBookView: View {
    @ObservedObject var viewModel: DetailBookViewModel
    
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.book.formats.imageJPEG)!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .padding()
            
            Divider()
            
            VStack(alignment: .leading)  {
                Text("Authors")
                    .font(.caption)
                
                ForEach(viewModel.book.authors, id: \.name) { author in
                    Text(author.name)
                        .font(.caption)
                    
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
                }
                
                Divider()

                Text("Bookshelves")
                    .font(.caption)
                
                ForEach(viewModel.book.bookshelves, id: \.self) { bookshelve in
                    Text(bookshelve)
                        .font(.caption)
                }
                
                Divider()
            }
            
            Image(systemName: "heart")
                .frame(width: 20, height: 20)
        }
        .navigationTitle(viewModel.book.title)
        .padding(16)
    }
}

#Preview {
    let response = ListBooks.makeListBooks()
    let viewModel = DetailBookViewModel(book: response.result.results.first!)
    return DetailBookView(viewModel: viewModel)
}
