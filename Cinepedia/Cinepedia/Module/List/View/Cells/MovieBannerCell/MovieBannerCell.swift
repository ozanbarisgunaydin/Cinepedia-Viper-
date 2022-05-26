//
//  MovieBannerCell.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 24.04.2022.
//

import UIKit

protocol MovieBannerCellProtocol: AnyObject {
    func setBannerImage(_ imageUrl: URL)
    func setbannerTitle(_ text: String)
    func setAccessibilityIdentifiers()
}

final class MovieBannerCell: UICollectionViewCell {
    
    @IBOutlet private weak var bannerImage: UIImageView! {
        didSet {
            bannerImage.layer.cornerRadius = 12
        }
    }
    @IBOutlet private weak var bannerTitleLabel: UILabel!
    
    var cellPresenter: MovieBannerCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
}

extension MovieBannerCell: MovieBannerCellProtocol {
    
    func setBannerImage(_ imageUrl: URL) {
        bannerImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_movie_poster"))
    }
    
    func setbannerTitle(_ text: String) {
        bannerTitleLabel.text = text
    }
    
}

extension MovieBannerCell {
    func setAccessibilityIdentifiers() {
        bannerImage.accessibilityIdentifier = "bannerImage"
        bannerTitleLabel.accessibilityIdentifier = "bannerTitleLabel"
    }
}
