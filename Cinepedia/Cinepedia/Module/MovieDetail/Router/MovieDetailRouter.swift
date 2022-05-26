//
//  MovieDetailRouter.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 26.04.2022.
//

import Foundation
import UIKit

protocol MovieDetailRouterProtocol: AnyObject {
    func navigate(_ route: MovieDetailRoutes)
}

enum MovieDetailRoutes {
    case detail(movieId: Int?)
    case openURL(imdbId: String)
}

final class MovieDetailRouter {
    
    weak var viewController: MovieDetailViewController?
    
    static func createModule() -> MovieDetailViewController {
        let view = MovieDetailViewController()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension MovieDetailRouter: MovieDetailRouterProtocol {
    
    func navigate(_ route: MovieDetailRoutes) {
        switch route {
            
        case .detail(let movieId):
            let detailVC = MovieDetailRouter.createModule()
            detailVC.movieId = movieId
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        
        case .openURL(let imdbId):
            if let url = URL(string: "https://www.imdb.com/title/" + imdbId) {
                UIApplication.shared.open(url)
            }
        }
    }
}
