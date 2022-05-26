//
//  MovieListCell.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 24.04.2022.
//

import UIKit
import SDWebImage

protocol MovieListCellProtocol: AnyObject {
    func setMovieImage(_ imageUrl: URL)
    func setTitleYearLabel(_ text: String)
    func setMovieDescriptionLabel(_ text: String)
    func setDateLabel(_ text: String)
    func setAccessibilityIdentifiers()
}

final class MovieListCell: UITableViewCell {
    
    @IBOutlet private weak var movieImage: UIImageView! {
        didSet {
            movieImage.layer.cornerRadius = 6
        }
    }
    @IBOutlet private weak var titleYearLabel: UILabel!
    @IBOutlet private weak var movieDescriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    
    var cellPresenter: MovieListCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
}

extension MovieListCell: MovieListCellProtocol {
    
    func setMovieImage(_ imageUrl: URL) {
        movieImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_movie_poster"))
    }
    
    func setTitleYearLabel(_ text: String) {
        titleYearLabel.text = text
    }
    
    func setMovieDescriptionLabel(_ text: String) {
        movieDescriptionLabel.text = text
    }
    
    func setDateLabel(_ text: String) {
        dateLabel.text = text
    }
    
}

extension MovieListCell {
    func setAccessibilityIdentifiers() {
        movieImage.accessibilityIdentifier = "listCellMovieImage"
        titleYearLabel.accessibilityIdentifier = "listCellTitleYearLabel"
        movieDescriptionLabel.accessibilityIdentifier = "listCellMovieDescriptionLabel"
        dateLabel.accessibilityIdentifier = "listCellDateLabel"
    }
}
