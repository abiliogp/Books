//
//  FavoriteView.swift
//  Books
//
//  Created by Abilio Gambim Parada on 05/05/2024.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var favoriteState: FavoriteState
    let bookId: Int
    
    var body: some View {
        Group {
            if (favoriteState.favorities.contains(bookId)) {
                Image(systemName: "heart.fill")
                    .frame(width: 20, height: 20)
            } else {
                Image(systemName: "heart")
                    .frame(width: 20, height: 20)
            }
        }
        .onTapGesture {
            favoriteState.markFavorite(bookId: bookId)
        }
    }
}

#Preview {
    FavoriteView(favoriteState: .init(userDefaults: MockUserDefaults()), bookId: 0)
}
