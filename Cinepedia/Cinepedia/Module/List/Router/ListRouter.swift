//
//  ListRouter.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 25.04.2022.
//

import Foundation
import UIKit

protocol ListRouterProtocol: AnyObject {
    func navigate(_ route: ListRoutes)
}

enum ListRoutes {
    case detail(movieId: Int?)
    case search(text: String?)
}

final class ListRouter {
    
    weak var viewController: ListViewController?
    
    static func createModule() -> ListViewController {
        let view = ListViewController()
        let interactor = ListInteractor()
        let router = ListRouter()
        let presenter = ListPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension ListRouter: ListRouterProtocol {
    
    func navigate(_ route: ListRoutes) {
        switch route {
            
        case .detail(let movieId):
            let detailVC = MovieDetailRouter.createModule()
            detailVC.movieId = movieId
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
            
        case .search(let text):
            guard let text = text,
                  text.count > 2 else { return }
            let searchVC = SearchRouter.createModule()
            searchVC.searchText = text
            
            if let topVC = viewController?.navigationController?.topViewController {
                searchVC.view.frame = topVC.view.bounds
                
                if topVC.children.count > 0 {
                    let viewControllers: [UIViewController] = topVC.children
                    viewControllers.last?.removeFromParent()
                    viewControllers.last?.view.removeFromSuperview()
                }
                viewController?.navigationController?.topViewController?.addChild(searchVC)
                viewController?.navigationController?.topViewController?.view.addSubview(searchVC.view)
            }
        }
    }
}
