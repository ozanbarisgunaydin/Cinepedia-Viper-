//
//  MovieDetailInteractor.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 26.04.2022.
//

import Foundation

protocol MovieDetailInteractorProtocol: AnyObject {
    func fetchMovieDetail(_ movieId: Int)
    func fetchSimilarMovies(_ movieId: Int)
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    func fetchMovieDetail(result: MovieDetailResult)
    func fetchSimilarMovies(result: SimilarMoviesResult)
}

typealias MovieDetailResult = Result<MovieDetailResponse, Error>
typealias SimilarMoviesResult = Result<SimilarMovieResponse, Error>

fileprivate var movieService: MovieServiceProtocol = MovieService()

final class MovieDetailInteractor {
    var output: MovieDetailInteractorOutputProtocol?
}

extension MovieDetailInteractor: MovieDetailInteractorProtocol {
    
    func fetchMovieDetail(_ movieId: Int) {
        movieService.fetchMovieDetail(movieID: movieId) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchMovieDetail(result: result)
        }
    }
    
    func fetchSimilarMovies(_ movieId: Int) {
        movieService.fetchSimilarMovies(movieID: movieId) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchSimilarMovies(result: result)
        }
    }
    
}
