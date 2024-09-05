//
//  MoviesDetailViewModel.swift
//  SwiftyMovies
//
//  Created by Tushar on 05/09/24.
//

import Foundation

class MoviesDetailViewModel {
     var movieDetail: MovieDetailModel?
    
    private let webServiceHelper: WebServiceHelper
    
    init(webServiceHelper: WebServiceHelper = WebServiceHelper.shared) {
        self.webServiceHelper = webServiceHelper
    }
    
    var updateDetailUI: (() -> Void)?
    var showNetworkError: (() -> Void)?
    var showLoadingIndicator: (() -> Void)?
    var hideLoadingIndicator: (() -> Void)?

    var title: String {
        return movieDetail?.title ?? ""
    }
    
    var year: String {
        return "Year: \(movieDetail?.year ?? "")"
    }
    
    var plot: String {
        return movieDetail?.plot ?? ""
    }
    
    var genre: String {
        return "Genre: \(movieDetail?.genre ?? "")"
    }
    
    var imdbRating: String {
        return "Rating: \(movieDetail?.imdbRating ?? "N/A")/10"
    }
    
    var posterURL: URL? {
        guard let poster = movieDetail?.poster else { return nil }
        return URL(string: poster)
    }
    
    func fetchMovieDetail(imdbID: String) {
        guard NetworkManager.shared.isReachable else {
            showNetworkError?()
            return
        }

        // Show loading indicator before starting the network request
        showLoadingIndicator?()
        
        let url = APIConstants.fullDetailURL(for: imdbID)
        
        WebServiceHelper.shared.get(url: url) { [weak self] (result: Result<MovieDetailModel, Error>) in
            // Hide loading indicator after the network request completes
            self?.hideLoadingIndicator?()
            
            switch result {
            case .success(let detail):
                self?.movieDetail = detail
                self?.updateDetailUI?()
            case .failure(let error):
                print("Error fetching movie detail: \(error.localizedDescription)")
                self?.showNetworkError?()
            }
        }
    }
}
