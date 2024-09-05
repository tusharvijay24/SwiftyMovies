//
//  SwiftyMoviesTests.swift
//  SwiftyMoviesTests
//
//  Created by Tushar on 05/09/24.
//

import XCTest
@testable import SwiftyMovies // Replace 'SwiftyMovies' with your app's module name
import Alamofire

final class SwiftyMoviesTests: XCTestCase {
    
    var userDefaultsManager: UserDefaultsManager!
    var mockWebServiceHelper: MockWebServiceHelper!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        userDefaultsManager = UserDefaultsManager.shared
        UserDefaults.standard.removeObject(forKey: userDefaultsManager.favoritesKey)
        mockWebServiceHelper = MockWebServiceHelper()
    }

    override func tearDownWithError() throws {
        if let manager = userDefaultsManager {
            UserDefaults.standard.removeObject(forKey: manager.favoritesKey)
        }

        userDefaultsManager = nil
        mockWebServiceHelper = nil

        try super.tearDownWithError()
    }

    // MARK: - UserDefaultsManager Tests
    
    func testAddFavoriteMovie() throws {
        // Given
        let imdbID = "tt0372784"
        
        // When
        userDefaultsManager.addFavoriteMovie(imdbID: imdbID)
        
        // Then
        XCTAssertTrue(userDefaultsManager.isMovieFavorite(imdbID: imdbID), "Movie should be marked as favorite")
    }

    func testRemoveFavoriteMovie() throws {
        // Given
        let imdbID = "tt0372784"
        userDefaultsManager.addFavoriteMovie(imdbID: imdbID)
        
        // When
        userDefaultsManager.removeFavoriteMovie(imdbID: imdbID)
        
        // Then
        XCTAssertFalse(userDefaultsManager.isMovieFavorite(imdbID: imdbID), "Movie should be removed from favorites")
    }

    func testIsMovieFavorite() throws {
        // Given
        let imdbID = "tt0372784"
        XCTAssertFalse(userDefaultsManager.isMovieFavorite(imdbID: imdbID), "Movie should not be favorite initially")

        // When
        userDefaultsManager.addFavoriteMovie(imdbID: imdbID)
        
        // Then
        XCTAssertTrue(userDefaultsManager.isMovieFavorite(imdbID: imdbID), "Movie should be marked as favorite")
    }

    // MARK: - Network Layer Tests

    func testNetworkSuccess() throws {
        // Given
        let expectation = XCTestExpectation(description: "Network success test")
        
        // Mock a successful network result
        let mockResult = MovieSearchModel(search: [MovieListModel.mock()], totalResults: "1", response: "True")
        mockWebServiceHelper.mockResult = .success(mockResult)
        
        // When
        mockWebServiceHelper.get(url: "https://example.com", parameters: nil, headers: nil) { (result: Result<MovieSearchModel, Error>) in
            switch result {
            case .success(let model):
                XCTAssertEqual(model.search?.count, 1, "Expected 1 movie in search results")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5.0)
    }

    func testNetworkFailure() throws {
        // Given
        let expectation = XCTestExpectation(description: "Network failure test")
        
        // Mock a failure result
        let mockError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock network error"])
        mockWebServiceHelper.mockResult = .failure(mockError)
        
        // When
        mockWebServiceHelper.get(url: "https://example.com", parameters: nil, headers: nil) { (result: Result<MovieSearchModel, Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Mock network error", "Expected a mock network error")
            }
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5.0)
    }
}


class MockWebServiceHelper: WebServiceHelper {
    var mockResult: Result<MovieSearchModel, Error>?

    override func get<T>(url: String, parameters: Parameters?, headers: HTTPHeaders?, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if let mockResult = mockResult as? Result<T, Error> {
            completion(mockResult)
        }
    }
}

extension MovieDetailModel {
    static func mock() -> MovieDetailModel {
        return MovieDetailModel(
            title: "Batman Begins",
            year: "2005",
            rated: "PG-13",
            released: "15 Jun 2005",
            runtime: "140 min",
            genre: "Action, Adventure",
            director: "Christopher Nolan",
            writer: "Bob Kane, David S. Goyer, Christopher Nolan",
            actors: "Christian Bale, Michael Caine, Ken Watanabe",
            plot: "After training with his mentor, Batman begins his fight to free crime-ridden Gotham City from corruption.",
            language: "English",
            country: "USA",
            awards: "Nominated for 1 Oscar. Another 16 wins & 72 nominations.",
            poster: "",
            ratings: [MovieRatingModel(source: "Internet Movie Database", value: "8.2/10")],
            metascore: "70",
            imdbRating: "8.2",
            imdbVotes: "1,321,456",
            imdbID: "tt0372784",
            type: "movie",
            dvd: nil,
            boxOffice: nil,
            production: nil,
            website: nil,
            response: "True"
        )
    }
}

// Mock data for MovieListModel
extension MovieListModel {
    static func mock() -> MovieListModel {
        return MovieListModel(title: "Batman Begins", year: "2005", imdbID: "tt0372784", type: "movie", poster: "")
    }
}
