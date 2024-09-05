//
//  Constant.swift
//  SwiftyMovies
//
//  Created by Tushar on 05/09/24.
//

import Foundation

struct APIConstants {
    static let omdbAPIBaseURL = "https://www.omdbapi.com/"
    static let apiKey = Configuration.apiKey 

    struct Endpoints {
        static let searchMovies = "?apikey=\(APIConstants.apiKey)&type=movie&s="
        static let movieDetail = "?apikey=\(APIConstants.apiKey)&i="
    }
    
    // Utility to get the full URL for search
    static func fullSearchURL(for query: String) -> String {
        return omdbAPIBaseURL + Endpoints.searchMovies + query
    }
    
    // Utility to get the full URL for movie details
    static func fullDetailURL(for imdbID: String) -> String {
        return omdbAPIBaseURL + Endpoints.movieDetail + imdbID
    }
}
