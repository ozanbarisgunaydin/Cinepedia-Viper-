//
//  MovieBannerCellPresenter.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 24.04.2022.
//

import Foundation

protocol MovieBannerCellPresenterProtocol: AnyObject {
    func load()
}

final class MovieBannerCellPresenter {
    
    weak var view: MovieBannerCellProtocol?
    private let movie: ListResult
    
    init(view: MovieBannerCellProtocol?, movie: ListResult) {
        self.view = view
        self.movie = movie
    }
}

extension MovieBannerCellPresenter: MovieBannerCellPresenterProtocol {
    
    func load() {
        let baseUrl = "https://image.tmdb.org/t/p/original/"
        if  let image = movie.backdrop_path,
            let url = URL(string: baseUrl + image) {
            view?.setBannerImage(url)
        }
        
        if let title = movie.title,
           let year = movie.release_date?.prefix(4) {
            let yearText = year == "" ? "" : " (" + year + ")"
            view?.setbannerTitle(title + yearText)
        }
        view?.setAccessibilityIdentifiers()
    }
    
}
