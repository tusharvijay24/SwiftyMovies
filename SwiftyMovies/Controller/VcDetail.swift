//
//  VcDetail.swift
//  SwiftyMovies
//
//  Created by Tushar on 05/09/24.
//

import UIKit
import SDWebImage

class VcDetail: UIViewController {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    var imdbID: String?
    private let viewModel = MoviesDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        if let imdbID = imdbID {
            viewModel.fetchMovieDetail(imdbID: imdbID)
        }
    }
    
    func setupBindings() {
        viewModel.updateDetailUI = { [weak self] in
            self?.configUI()
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
    
    func setupUI() {
        self.title = "Movie Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 34)
        ]

        lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
        lblTitle.textColor = .black
        
        lblDescription.numberOfLines = 0
        lblGenre.numberOfLines = 0
        lblRating.numberOfLines = 0
    }


    func configUI() {
        lblTitle.text = viewModel.title
        lblDescription.attributedText = createAttributedText(title: "Overview", content: viewModel.plot)
        lblGenre.attributedText = createAttributedText(title: "❤ Genre", content: viewModel.genre)
        lblRating.attributedText = createAttributedText(title: "🌟 Rating", content: viewModel.imdbRating)
        
        if let posterURL = viewModel.posterURL {
            imgPoster.sd_setImage(with: posterURL, placeholderImage: UIImage(named: "logo"))
        } else {
            imgPoster.image = UIImage(named: "logo")
        }
    }
    
    private func createAttributedText(title: String, content: String) -> NSAttributedString {
        let boldAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        let regularAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ]
        
        let boldString = NSMutableAttributedString(string: "\(title) \n", attributes: boldAttribute)
        let regularString = NSAttributedString(string: content, attributes: regularAttribute)
        
        boldString.append(regularString)
        return boldString
    }
}
