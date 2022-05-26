//
//  SearchInteractor.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 25.04.2022.
//

import Foundation

protocol SearchInteractorProtocol: AnyObject {
    func fetchSearchedMovies(searchText query: String)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func fetchSearchedMovies(result: SearchedMovieResult)
}

typealias SearchedMovieResult = Result<SearchResponse, Error>
fileprivate var movieService: MovieServiceProtocol = MovieService()

final class SearchInteractor {
    var output: SearchInteractorOutputProtocol?
}

extension SearchInteractor: SearchInteractorProtocol {
    
    func fetchSearchedMovies(searchText query: String) {
        movieService.fetchSearch(query: query) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchSearchedMovies(result: result)
        }
    }

}
