//
//  Books.swift
//  Books
//
//  Created by Abilio Gambim Parada on 04/05/2024.
//

import Foundation

// MARK: - ListBooks
public struct ListBooks: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Book]
}

// MARK: - Book
public struct Book: Codable {
    let id: Int
    let title: String
    let authors, translators: [Author]
    let subjects, bookshelves: [String]
    let languages: [Language]
    let copyright: Bool
    let mediaType: MediaType
    let formats: Formats
    let downloadCount: Int

    enum CodingKeys: String, CodingKey {
        case id, title, authors, translators, subjects, bookshelves, languages, copyright
        case mediaType = "media_type"
        case formats
        case downloadCount = "download_count"
    }
}

// MARK: - Author
public struct Author: Codable {
    let name: String
    let birthYear, deathYear: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
        case deathYear = "death_year"
    }
}

// MARK: - Formats
public struct Formats: Codable {
    let textHTML, applicationEpubZip, applicationXMobipocketEbook: String
    let applicationRDFXML: String
    let imageJPEG: String
    let textPlainCharsetUsASCII: String
    let applicationOctetStream: String
    let textHTMLCharsetUTF8: String?
    let textPlainCharsetUTF8, textPlainCharsetISO88591: String?
    let textHTMLCharsetISO88591: String?

    enum CodingKeys: String, CodingKey {
        case textHTML = "text/html"
        case applicationEpubZip = "application/epub+zip"
        case applicationXMobipocketEbook = "application/x-mobipocket-ebook"
        case applicationRDFXML = "application/rdf+xml"
        case imageJPEG = "image/jpeg"
        case textPlainCharsetUsASCII = "text/plain; charset=us-ascii"
        case applicationOctetStream = "application/octet-stream"
        case textHTMLCharsetUTF8 = "text/html; charset=utf-8"
        case textPlainCharsetUTF8 = "text/plain; charset=utf-8"
        case textPlainCharsetISO88591 = "text/plain; charset=iso-8859-1"
        case textHTMLCharsetISO88591 = "text/html; charset=iso-8859-1"
    }
}

public enum Language: String, Codable {
    case en = "en"
    case tl = "tl"
}

public enum MediaType: String, Codable {
    case text = "Text"
}
