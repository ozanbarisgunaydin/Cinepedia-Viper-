//
//  SimilarMovieCellPresenter.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 26.04.2022.
//

import Foundation

protocol SimilarMovieCellPresenterProtocol: AnyObject {
    func load()
}

final class SimilarMovieCellPresenter {
    
    weak var view: SimilarMovieCellProtocol?
    private let movie: SimilarMovieOutput
    
    init(view: SimilarMovieCellProtocol?, movie: SimilarMovieOutput) {
        self.view = view
        self.movie = movie
    }
}

extension SimilarMovieCellPresenter: SimilarMovieCellPresenterProtocol {
    
    func load() {
        let baseUrl = "https://image.tmdb.org/t/p/w500/"
        if  let image = movie.backdrop_path,
            let url = URL(string: baseUrl + image) {
            view?.setMoviePoster(url)
        }
        
        if let title = movie.title,
           let year = movie.release_date?.prefix(4) {
            let yearText = year == "" ? "" : " (" + year + ")"
            view?.setTitleYearLabel(title + yearText)
        }
        
        view?.setAccessibilityIdentifiers()
    }
    
}
