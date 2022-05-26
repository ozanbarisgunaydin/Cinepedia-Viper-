//
//  ServiceManager.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 24.04.2022.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchListUpComing(completionHandler: @escaping (MovieListResult) -> ())
    func fetchListNowPlaying(completionHandler: @escaping (MovieListResult) -> ())
    func fetchSearch(query: String, completionHandler: @escaping (SearchedMovieResult) -> ())
    func fetchMovieDetail(movieID: Int, completionHandler: @escaping (MovieDetailResult) -> ())
    func fetchSimilarMovies(movieID: Int, completionHandler: @escaping (SimilarMoviesResult) -> ())
}

struct MovieService: MovieServiceProtocol {
    
  
    func fetchListUpComing(completionHandler: @escaping (MovieListResult) -> ()) {
        NetworkManager.shared.request(Router.listUpcoming, decodeToType: ListResponse.self, completionHandler: completionHandler)
    }

    func fetchListNowPlaying(completionHandler: @escaping (MovieListResult) -> ()) {
        NetworkManager.shared.request(Router.listNowPlaying, decodeToType: ListResponse.self, completionHandler: completionHandler)
    }

    func fetchSearch(query: String, completionHandler: @escaping (SearchedMovieResult) -> ()) {
        NetworkManager.shared.request(Router.search(query: query), decodeToType: SearchResponse.self, completionHandler: completionHandler)
    }

    func fetchMovieDetail(movieID: Int, completionHandler: @escaping (MovieDetailResult) -> ()) {
        NetworkManager.shared.request(Router.movieDetail(movieID: movieID), decodeToType: MovieDetailResponse.self, completionHandler: completionHandler)
    }

    func fetchSimilarMovies(movieID: Int, completionHandler: @escaping (SimilarMoviesResult) -> ()) {
        NetworkManager.shared.request(Router.similarMovies(movieID: movieID), decodeToType: SimilarMovieResponse.self, completionHandler: completionHandler)
    }
}
