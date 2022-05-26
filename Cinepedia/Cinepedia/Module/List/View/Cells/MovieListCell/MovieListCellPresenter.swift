//
//  MovieListCellPresenter.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 24.04.2022.
//

import Foundation

protocol MovieListCellPresenterProtocol: AnyObject {
    func load()
}

final class MovieListCellPresenter {
    
    weak var view: MovieListCellProtocol?
    private let movie: ListResult
    
    init(view: MovieListCellProtocol?, movie: ListResult) {
        self.view = view
        self.movie = movie
    }
}

extension MovieListCellPresenter: MovieListCellPresenterProtocol {
    
    func load() {
        let baseUrl = "https://image.tmdb.org/t/p/w500/"
        if  let image = movie.backdrop_path,
            let url = URL(string: baseUrl + image) {
            view?.setMovieImage(url)
        }
        
        if let title = movie.title,
           let year = movie.release_date?.prefix(4) {
            let yearText = year == "" ? "" : " (" + year + ")"
            view?.setTitleYearLabel(title + yearText)
        }
        
        if let date = movie.release_date  {
            let formatedDate = date.convertDateFormat(inputDate: date)
            view?.setDateLabel(formatedDate)
        }
        
        if let overview = movie.overview {
            view?.setMovieDescriptionLabel(overview)
        }
        
        view?.setAccessibilityIdentifiers()
    }
    
}

