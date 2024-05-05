//
//  DetailBookViewModel.swift
//  Books
//
//  Created by Abilio Gambim Parada on 05/05/2024.
//

import SwiftUI

class DetailBookViewModel: ObservableObject {
    @Published var book: Book
    
    init(book: Book) {
        self.book = book
    }
}
