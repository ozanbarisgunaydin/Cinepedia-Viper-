//
//  SimilarMovieCell.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 26.04.2022.
//

import UIKit
import SDWebImage

protocol SimilarMovieCellProtocol: AnyObject {
    func setMoviePoster(_ imageUrl: URL)
    func setTitleYearLabel(_ text: String)
    func setAccessibilityIdentifiers()
}

final class SimilarMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePosterImage: UIImageView! {
        didSet {
            moviePosterImage.layer.cornerRadius = 6
        }
    }
    @IBOutlet weak var titleDateLabel: UILabel!
    
    var cellPresenter: SimilarMovieCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
}

extension SimilarMovieCell: SimilarMovieCellProtocol {
    
    func setMoviePoster(_ imageUrl: URL) {
        moviePosterImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_movie_poster"))
    }
    
    func setTitleYearLabel(_ text: String) {
        titleDateLabel.text = text
    }
    
}

extension SimilarMovieCell {
    func setAccessibilityIdentifiers() {
        moviePosterImage.accessibilityIdentifier = "detailCellMoviePosterImage"
        titleDateLabel.accessibilityIdentifier = "detailCellMovieTitleLabel"
    }
}
