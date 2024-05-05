//
//  ListBooks+Maker.swift
//  Books
//
//  Created by Abilio Gambim Parada on 04/05/2024.
//

import Foundation

extension ListBooks {
    static func makeListBooks() -> (data: Data, result: ListBooks) {
        let anyURLStr = "https://example.com/sample_book.html"
        
        let book = Book(id: 123,
                        title: "Sample Book",
                        authors: [Author(name: "John Doe", birthYear: 1900, deathYear: nil)],
                        translators: [],
                        subjects: ["Fiction"],
                        bookshelves: ["Bestsellers"],
                        languages: [.en],
                        copyright: true,
                        mediaType: .text,
                        formats: Formats(textHTML: anyURLStr,
                                         applicationEpubZip: anyURLStr,
                                         applicationXMobipocketEbook: anyURLStr,
                                         applicationRDFXML: anyURLStr,
                                         imageJPEG: anyURLStr,
                                         textPlainCharsetUsASCII: anyURLStr,
                                         applicationOctetStream: anyURLStr,
                                         textHTMLCharsetUTF8: anyURLStr,
                                         textPlainCharsetUTF8: anyURLStr,
                                         textPlainCharsetISO88591: anyURLStr,
                                         textHTMLCharsetISO88591: anyURLStr),
                        downloadCount: 100)
        
        let list = ListBooks(count: 1,
                             next: "",
                             previous: nil,
                             results: [book])
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(list)
        
        return (data, list)
    }
}
