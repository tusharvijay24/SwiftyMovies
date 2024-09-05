//
//  MovieListCell.swift
//  SwiftyMovies
//
//  Created by Tushar on 05/09/24.
//

import UIKit

class MovieListCell: UITableViewCell {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblRelease: UILabel!
    @IBOutlet weak var btnFav: UIButton!
    
    var favoriteButtonAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        btnFav.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }

    func configure(with movie: MovieListModel) {
        lblTitle.text = movie.title
        lblRelease.text = movie.year
        imgPoster.sd_setImage(with: URL(string: movie.poster), placeholderImage: UIImage(named: "logo"))
        
       
        btnFav.isSelected = movie.isFavorite
        let buttonImage = movie.isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        btnFav.setImage(buttonImage, for: .normal)
    }

    @objc private func favoriteButtonTapped() {
        favoriteButtonAction?()
    }
}
