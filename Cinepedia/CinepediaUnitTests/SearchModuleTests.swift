//
//  SearchModuleTests.swift
//  CinepediaUnitTests
//
//  Created by Ozan Barış Günaydın on 28.04.2022.
//

import XCTest
@testable import Cinepedia
@testable import Alamofire

class SearchModuleTests: XCTestCase {
    var presenter: SearchPresenter!
    var view: MockSearchViewController!
    var interactor: MockSearchInteractor!
    var router: MockSearchRouter!
    
    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, router: router, interactor: interactor)
    }
    
    override func tearDown() {
        view = nil
        presenter = nil
        interactor = nil
        router = nil
    }
    
    // MARK: - Test Methods
    func test_viewDidLoad_invokes_required_view_setup_methods() {
        presenter.viewDidLoad()
        XCTAssertTrue(view.isCalledSetupTableView)
        XCTAssertTrue(view.isCalledShowLoading)
    }
    
    func test_viewDidLoad_invokes_fetch_datas_with_search_text() {
        presenter.viewDidLoad()
        XCTAssertEqual(view.getSearchText(), "Prestige") /// Search text parameter gived by the Mock Search View Controller method
        XCTAssertTrue(interactor.isCalledGetSearchedMovies)
    }
    
    func test_view_methods_with_filled_data() {
        presenter.viewDidLoad()
        presenter.fetchSearchedMovies(result: SearchedMovieResult.success(createSearchResponse()))
        XCTAssertTrue(view.isCalledReloadData)
        XCTAssertTrue(view.isCalledHideLoading)
        XCTAssertEqual(presenter.numberOfItems(), 1)
        XCTAssertEqual(presenter.movie(0)?.id, 416141)
    }
    
    func test_view_methods_with_empty_data() {
        presenter.viewDidLoad()
        presenter.fetchSearchedMovies(result: SearchedMovieResult.success(.init(page: nil, results: nil, total_pages: nil, total_results: nil)))
        XCTAssertFalse(view.isCalledReloadData)
        XCTAssertTrue(view.isCalledHideLoading)
        XCTAssertEqual(presenter.numberOfItems(), 0)
        XCTAssertEqual(presenter.movie(0)?.id, nil)
    }
    
    func test_view_methods_with_no_data() {
        presenter.viewDidLoad()
        presenter.fetchSearchedMovies(result: SearchedMovieResult.failure(AFError.invalidURL(url: "")))
        XCTAssertFalse(view.isCalledReloadData)
        XCTAssertTrue(view.isCalledHideLoading)
        XCTAssertEqual(presenter.numberOfItems(), 0)
        XCTAssertEqual(presenter.movie(0)?.id, nil)
    }
    
    func test_navigate_detail_with_filled_data() {
        presenter.viewDidLoad()
        presenter.fetchSearchedMovies(result: SearchedMovieResult.success(createSearchResponse()))
        presenter.didSelectRowAt(index: 0)
        XCTAssertTrue(router.isNavigateDetail)
    }
    
    func test_navigate_detail_with_no_data() {
        presenter.viewDidLoad()
        presenter.fetchSearchedMovies(result: SearchedMovieResult.failure(AFError.invalidURL(url: "")))
        presenter.didSelectRowAt(index: 0)
        XCTAssertFalse(router.isNavigateDetail)
    }
    
    // MARK: - Private Methods
    private func createSearchResponse() -> SearchResponse {
        .init(
            page: 0,
            results: [
                .init(
                    adult: false,
                    backdrop_path: "backdrop_path",
                    genre_ids: [6,1],
                    id: 416141,
                    original_language: "original_language",
                    original_title: "original_title",
                    overview: "overview",
                    popularity: 10.0,
                    poster_path: "poster_path",
                    release_date: "release_date",
                    title: "title",
                    video: true,
                    vote_average: 6.1,
                    vote_count: 8
                )
            ],
            total_pages: 3,
            total_results: 5
        )
    }
    
    
}

// MARK: - Mock Classes
final class MockSearchViewController: SearchViewControllerProtocol {
    
    var isCalledReloadData = false
    var isCalledShowLoading = false
    var isCalledHideLoading = false
    var isCalledSetupTableView = false
    var isCalledGetSearchText = false

    func reloadData() {
        isCalledReloadData = true
    }
    
    func showLoadingView() {
        isCalledShowLoading = true
    }
    
    func hideLoadingView() {
        isCalledHideLoading = true
    }
    
    func setupTableView() {
        isCalledSetupTableView = true
    }
    
    func getSearchText() -> String? {
        isCalledGetSearchText = true
        return "Prestige"
    }
   
}

final class MockSearchInteractor: SearchInteractorProtocol {
    
    var isCalledGetSearchedMovies = false
    
    func fetchSearchedMovies(searchText query: String) {
        isCalledGetSearchedMovies = true
    }
    
}

final class MockSearchRouter: SearchRouterProtocol {
    
    var isNavigateDetail = false
    
    func navigate(_ route: SearchRoutes) {
        switch route {
        case .detail(_):
            isNavigateDetail = true
        }
    }
   
}
