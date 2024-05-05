//
//  FavoriteStateTests.swift
//  BooksTests
//
//  Created by Abilio Gambim Parada on 05/05/2024.
//

import XCTest
@testable import Books

final class FavoriteStateTests: XCTestCase {
    
    func test_mark_favorite() {
        let favoriteState = FavoriteState()
        
        favoriteState.markFavorite(bookId: 1)
        
        XCTAssertTrue(favoriteState.favorities.contains(1), "Book with ID 1 should be marked as favorite")
        
        favoriteState.markFavorite(bookId: 1)
        
        XCTAssertFalse(favoriteState.favorities.contains(1), "Book with ID 1 should be unmarked as favorite")
        
        favoriteState.markFavorite(bookId: 2)
        
        XCTAssertTrue(favoriteState.favorities.contains(2), "Book with ID 2 should be marked as favorite")
    }
    
    func test_load_and_save() {
        let mockUserDefaults = MockUserDefaults()
        let favoriteState = FavoriteState(userDefaults: mockUserDefaults)
        let favoritesToSave: Set<Int> = [1, 2, 3, 4, 5]
        
        favoriteState.favorities = favoritesToSave
        favoriteState.save()
        favoriteState.favorities.removeAll()
        favoriteState.load()
        
        XCTAssertEqual(favoriteState.favorities, favoritesToSave, "Favorites loaded from UserDefaults should match saved favorites")
    }
}
