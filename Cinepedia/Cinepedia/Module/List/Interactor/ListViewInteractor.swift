//
//  ListViewInteractor.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 24.04.2022.
//

import Foundation

protocol ListInteractorProtocol: AnyObject {
    func fetchUpComingMovies()
    func fetchNowPlayingMovies()
}

protocol ListInteractorOutputProtocol: AnyObject {
    func fetchUpComingMovies(result: MovieListResult)
    func fetchNowPlayingMovies(result: MovieListResult)
}

typealias MovieListResult = Result<ListResponse, Error>
fileprivate var movieService: MovieServiceProtocol = MovieService()

final class ListInteractor {
    var output: ListInteractorOutputProtocol?
}

extension ListInteractor: ListInteractorProtocol {
    
    func fetchUpComingMovies() {
        movieService.fetchListUpComing { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchUpComingMovies(result: result)
        }
    }
    
    func fetchNowPlayingMovies() {
        movieService.fetchListNowPlaying { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchNowPlayingMovies(result: result)
        }
    }
    
}
