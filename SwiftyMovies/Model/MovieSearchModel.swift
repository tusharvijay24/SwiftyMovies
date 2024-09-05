//
//  MovieSearchModel.swift
//  SwiftyMovies
//
//  Created by Tushar on 05/09/24.
//

import Foundation
struct MovieSearchModel: Codable {
    let search: [MovieListModel]?
    let totalResults: String?
    let response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}
