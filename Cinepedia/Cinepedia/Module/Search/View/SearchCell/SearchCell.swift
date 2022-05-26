//
//  SearchCell.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 25.04.2022.
//

import UIKit

protocol SearchCellProtocol: AnyObject {
    func setTitleLabel(_ text: String)
    func setAccessibilityIdentifiers()
}

final class SearchCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    var cellPresenter: SearchCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
}

extension SearchCell: SearchCellProtocol {
    
    func setTitleLabel(_ text: String) {
        movieTitleLabel.text = text
    }

}

extension SearchCell {
    func setAccessibilityIdentifiers() {
        movieTitleLabel.accessibilityIdentifier = "movieTitleLabel"
    }
}
