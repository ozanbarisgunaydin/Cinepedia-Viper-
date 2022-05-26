//
//  ListPresenter.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 24.04.2022.
//

import Foundation

protocol ListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfItemsInSection() -> Int
    func numberOfItems() -> Int
    func banner(_ index: Int) -> ListResult?
    func movie(_ index: Int) -> ListResult?
    func didSelectRowAt(index: Int)
    func didSelectItemAt(index: Int)
    func searchMovie(searchText: String)
}

final class ListPresenter: ListPresenterProtocol {
    
    unowned var view: ListViewControllerProtocol?
    let router: ListRouterProtocol!
    let interactor: ListInteractorProtocol!
    
    private var banners: [ListResult] = []
    private var movies: [ListResult] = []
    
    init(
        view: ListViewControllerProtocol,
        router: ListRouterProtocol,
        interactor: ListInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.setupCollectionView()
        view?.setupTableView()
        view?.setupSearchView()
        fetchMovies()
    }
    
    func viewWillAppear() {
        view?.setUpView()
    }
    
    func numberOfItemsInSection() -> Int {
        return banners.count
    }
    
    func numberOfItems() -> Int {
        return movies.count
    }
    
    func banner(_ index: Int) -> ListResult? {
        return banners[safe: index]
    }
    
    func movie(_ index: Int) -> ListResult? {
        return movies[safe: index]
    }
    
    func didSelectItemAt(index: Int) {
        guard let banner = banner(index) else { return }
        router.navigate(.detail(movieId: banner.id))
    }
    
    func didSelectRowAt(index: Int) {
        guard let movie = movie(index) else { return }
        router.navigate(.detail(movieId: movie.id))
    }
    
    func searchMovie(searchText: String) {
        router.navigate(.search(text: searchText))
    }
    
    private func fetchMovies() {
        view?.showLoadingView()
        interactor.fetchUpComingMovies()
        interactor.fetchNowPlayingMovies()
    }
}

extension ListPresenter: ListInteractorOutputProtocol {
    
    func fetchUpComingMovies(result: MovieListResult) {
        view?.hideLoadingView()
        
        switch result {
        case .success(let bannersResult):
            if let banners = bannersResult.results {
                self.banners = banners
                view?.reloadData()
            }
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchNowPlayingMovies(result: MovieListResult) {
        view?.hideLoadingView()
        
        switch result {
        case .success(let moviesResult):
            if let movies = moviesResult.results {
                self.movies = movies
                view?.reloadData()
            }
        case .failure(let error):
            print(error)
        }
    }
    
}
