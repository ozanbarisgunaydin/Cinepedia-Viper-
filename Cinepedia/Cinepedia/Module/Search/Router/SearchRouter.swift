//
//  SearchRouter.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 25.04.2022.
//

import Foundation

protocol SearchRouterProtocol: AnyObject {
    func navigate(_ route: SearchRoutes)
}

enum SearchRoutes {
    case detail(movieId: Int?)
}

final class SearchRouter {
    
    weak var viewController: SearchViewController?
    
    static func createModule() -> SearchViewController {
        let view = SearchViewController()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension SearchRouter: SearchRouterProtocol {
    
    func navigate(_ route: SearchRoutes) {
        switch route {
        case .detail(let movieId):
            let detailVC = MovieDetailRouter.createModule()
            detailVC.movieId = movieId
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}
