//
//  ImageLoaderView.swift
//  Books
//
//  Created by Abilio Gambim Parada on 06/05/2024.
//

import SwiftUI

struct ImageLoaderView: View {
    let urlString: String
    
    var body: some View {
        Group {
            if let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            } else {
                ProgressView()
            }
        }
    }
}

#Preview {
    ImageLoaderView(urlString: "https://www.gutenberg.org/cache/epub/84/pg84.cover.medium.jpg")
}
