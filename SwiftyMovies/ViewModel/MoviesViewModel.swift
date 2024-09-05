//
//  MoviesViewModel.swift
//  SwiftyMovies
//
//  Created by Tushar on 05/09/24.
//

import Foundation

class MoviesViewModel {
    private var movies: [MovieListModel] = []
    
    private let webServiceHelper: WebServiceHelper
    
    init(webServiceHelper: WebServiceHelper = WebServiceHelper.shared) {
        self.webServiceHelper = webServiceHelper
    }
    
    var reloadTableView: (() -> Void)?
    var showNetworkError: (() -> Void)?
    var showLoadingIndicator: (() -> Void)?
    var hideLoadingIndicator: (() -> Void)?

    var numberOfMovies: Int {
        return movies.count
    }

    func movie(at index: Int) -> MovieListModel {
        return movies[index]
    }

    func fetchMovies(query: String) {
        guard NetworkManager.shared.isReachable else {
            showNetworkError?()
            return
        }

        // Show loading indicator before starting the network request
        showLoadingIndicator?()

        let url = APIConstants.fullSearchURL(for: query)
        
        WebServiceHelper.shared.get(url: url) { [weak self] (result: Result<MovieSearchModel, Error>) in
            // Hide loading indicator after the network request completes
            self?.hideLoadingIndicator?()
            
            switch result {
            case .success(let response):
                self?.movies = response.search ?? []
                self?.reloadTableView?()
            case .failure(let error):
                print("Error fetching movies: \(error.localizedDescription)")
                self?.showNetworkError?()
            }
        }
    }
}
