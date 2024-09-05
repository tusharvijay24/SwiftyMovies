//
//  MovieListModel.swift
//  SwiftyMovies
//
//  Created by Tushar on 05/09/24.
//

import Foundation

struct MovieListModel: Codable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    
    var isFavorite: Bool {
        get {
            return UserDefaultsManager.shared.isMovieFavorite(imdbID: imdbID)
        }
        set {
            if newValue {
                UserDefaultsManager.shared.addFavoriteMovie(imdbID: imdbID)
            } else {
                UserDefaultsManager.shared.removeFavoriteMovie(imdbID: imdbID)
            }
        }
    }

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
