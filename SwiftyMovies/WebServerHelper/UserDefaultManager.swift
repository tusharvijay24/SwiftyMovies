//
//  UserDefaultManager.swift
//  SwiftyMovies
//
//  Created by Tushar on 05/09/24.
//

import Foundation
import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    let favoritesKey = "favoriteMovies"

    private init() {}

    func isMovieFavorite(imdbID: String) -> Bool {
        let favorites = getFavoriteMovies()
        return favorites.contains(imdbID)
    }

    func addFavoriteMovie(imdbID: String) {
        var favorites = getFavoriteMovies()
        if !favorites.contains(imdbID) {
            favorites.append(imdbID)
            saveFavoriteMovies(favorites)
        }
    }

    func removeFavoriteMovie(imdbID: String) {
        var favorites = getFavoriteMovies()
        if let index = favorites.firstIndex(of: imdbID) {
            favorites.remove(at: index)
            saveFavoriteMovies(favorites)
        }
    }

    private func getFavoriteMovies() -> [String] {
        return UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
    }

    private func saveFavoriteMovies(_ favorites: [String]) {
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
    }
}
