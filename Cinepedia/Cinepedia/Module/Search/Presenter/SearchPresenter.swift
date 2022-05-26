//
//  SearchPresenter.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 25.04.2022.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func movie(_ index: Int) -> SearchOutput?
    func didSelectRowAt(index: Int)
}

final class SearchPresenter: SearchPresenterProtocol {
    
    unowned var view: SearchViewControllerProtocol?
    let router: SearchRouterProtocol!
    let interactor: SearchInteractorProtocol!
    
    private var movies: [SearchOutput] = []
    
    init(
        view: SearchViewControllerProtocol,
        router: SearchRouterProtocol,
        interactor: SearchInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.setupTableView()
        if let searchText = view?.getSearchText() {
            fetchSearchedMovies(with: searchText)
        }
    }
    
    func numberOfItems() -> Int {
        return movies.count
    }
    
    func movie(_ index: Int) -> SearchOutput? {
        return movies[safe: index]
    }
    
    func didSelectRowAt(index: Int) {
        guard let movie = movie(index) else { return }
        router.navigate(.detail(movieId: movie.id))
    }
    
    private func fetchSearchedMovies(with searchText: String) {
        view?.showLoadingView()
        interactor.fetchSearchedMovies(searchText: searchText)
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func fetchSearchedMovies(result: SearchedMovieResult) {
        view?.hideLoadingView()
        switch result {
            
        case .success(let searchResult):
            if let movies = searchResult.results {
                self.movies.append(contentsOf: movies)
                view?.reloadData()
            }
            
        case .failure(let error):
            print(error)
        }
    }
}
