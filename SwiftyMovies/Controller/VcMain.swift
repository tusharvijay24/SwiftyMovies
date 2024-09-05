//
//  ViewController.swift
//  SwiftyMovies
//
//  Created by Tushar on 05/09/24.
//

import UIKit
import SDWebImage

class VcMain: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tvSearchList: UITableView!
    
    private let viewModel = MoviesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupBindings()
        viewModel.fetchMovies(query: "Batman")
    }
    
    func configUI() {
        tvSearchList.delegate = self
        tvSearchList.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = "Search for movies..."
    }

    func setupBindings() {
        viewModel.reloadTableView = { [weak self] in
            self?.tvSearchList.reloadData()
        }

        viewModel.showNetworkError = { [weak self] in
            guard let self = self else { return }
            showAlertWithOutCancel(on: self, title: "Error!", message: "No network connection. Please check your internet settings.", buttonTitle: "OK") {}
        }
        
        viewModel.showLoadingIndicator = { [weak self] in
            guard let self = self else { return }
            ShowActivityIndicator(uiView: self.view)
        }
        
        viewModel.hideLoadingIndicator = { [weak self] in
            guard let self = self else { return }
            HideActivityIndicator(uiView: self.view)
        }
    }
    
    private func navigateToDetailScreen(with imdbID: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "VcDetail") as? VcDetail {
            detailVC.imdbID = imdbID
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
   
}

extension VcMain: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as? MovieListCell else {
            return UITableViewCell()
        }
        let movie = viewModel.movie(at: indexPath.row)
        cell.configure(with: movie)
        
        // Handle favorite button action
        cell.favoriteButtonAction = { [weak self] in
            self?.toggleFavorite(for: movie)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movie(at: indexPath.row)
        navigateToDetailScreen(with: movie.imdbID)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    private func toggleFavorite(for movie: MovieListModel) {
        var updatedMovie = movie
        updatedMovie.isFavorite.toggle()
        tvSearchList.reloadData()
    }
}

extension VcMain: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        viewModel.fetchMovies(query: query)
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.fetchMovies(query: "")
        }
    }
}
