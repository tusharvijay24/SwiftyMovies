//
//  MovieRatingModel.swift
//  SwiftyMovies
//
//  Created by Tushar on 05/09/24.
//

import Foundation
struct MovieRatingModel: Codable {
    let source: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
