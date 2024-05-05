//
//  FavoriteState.swift
//  Books
//
//  Created by Abilio Gambim Parada on 05/05/2024.
//

import Foundation

class FavoriteState: ObservableObject {
    @Published var favorities = Set<Int>()
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func load() {
        if let arrayFav = userDefaults.array(forKey: UserDefaults.Key.favorite.rawValue) as? [Int] {
            favorities = Set(arrayFav)
        }
    }
    
    func save() {
        userDefaults.set(Array(favorities), forKey:  UserDefaults.Key.favorite.rawValue)
    }

    func markFavorite(bookId: Int) {
        if favorities.contains(bookId) {
            favorities.remove(bookId)
        } else {
            favorities.insert(bookId)
        }
        save()
    }
}
