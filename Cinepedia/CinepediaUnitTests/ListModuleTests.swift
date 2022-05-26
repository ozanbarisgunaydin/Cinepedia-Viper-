//
//  ListModuleTests.swift
//  CinepediaUnitTests
//
//  Created by Ozan Barış Günaydın on 28.04.2022.
//

import XCTest
@testable import Cinepedia
@testable import Alamofire

class ListModuleTests: XCTestCase {

    var presenter: ListPresenter!
    var view: MockListViewController!
    var interactor: MockListInteractor!
    var router: MockListRouter!
    
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
    func test_viewDidLoad_Invoke_SetUp_Views() {
        presenter.viewDidLoad()
        XCTAssertTrue(view.isCalledSetupCollectionView)
        XCTAssertTrue(view.isCalledSetupTableView)
        XCTAssertTrue(view.isCalledSetupSearchView)
        XCTAssertTrue(view.isCalledShowLoading)
    }
    
    func test_viewWillAppear_Invoke_SetUp_Views() {
        presenter.viewWillAppear()
        XCTAssertTrue(view.isCalledSetupView)
    }
    
    func test_view_methods_with_no_data() {
        presenter.viewDidLoad()
        presenter.fetchUpComingMovies(result: .failure(AFError.invalidURL(url: "")))
        presenter.fetchNowPlayingMovies(result: .failure(AFError.invalidURL(url: "")))
        
        XCTAssertFalse(view.isCalledReloadData)
        XCTAssertTrue(view.isCalledHideLoading)
        
        XCTAssertEqual(presenter.numberOfItems(), 0)
        XCTAssertEqual(presenter.movie(0)?.id, nil)
        XCTAssertEqual(presenter.banner(0)?.id, nil)
        XCTAssertEqual(presenter.numberOfItemsInSection(), 0)
    }
    
    func test_viewDidLoad_Invoke_Fetch_Datas_Succes_Status_Empty_Data() {
        presenter.viewDidLoad()
        XCTAssertTrue(interactor.isFetchUpComingMoviesCalled)
        XCTAssertTrue(interactor.isFetchNowPlayingMoviesCalled)
        
        presenter.fetchUpComingMovies(result: .success(.init(dates: nil, page: nil, results: nil, total_pages: nil, total_results: nil)))
        presenter.fetchNowPlayingMovies(result: .success(.init(dates: nil, page: nil, results: nil, total_pages: nil, total_results: nil)))
        
        XCTAssertFalse(view.isCalledReloadData)
        XCTAssertTrue(view.isCalledHideLoading)
        
        XCTAssertEqual(presenter.banner(0)?.id, nil)
        XCTAssertEqual(presenter.movie(0)?.id, nil)
        XCTAssertEqual(presenter.numberOfItems(), 0)
        XCTAssertEqual(presenter.numberOfItemsInSection(), 0)
    }
    
    func test_viewDidLoad_Invoke_Fetch_Datas_Succes_Status_Filled_Data() {
        presenter.viewDidLoad()
        XCTAssertTrue(interactor.isFetchUpComingMoviesCalled)
        XCTAssertTrue(interactor.isFetchNowPlayingMoviesCalled)
        presenter.fetchUpComingMovies(result: .success(createListResponse()))
        presenter.fetchNowPlayingMovies(result: .success(createListResponse()))
        XCTAssertTrue(view.isCalledReloadData)
        XCTAssertTrue(view.isCalledHideLoading)
        XCTAssertEqual(presenter.banner(0)?.id, 416141)
        XCTAssertEqual(presenter.movie(0)?.id, 416141)
        XCTAssertEqual(presenter.numberOfItems(), 1)
        XCTAssertEqual(presenter.numberOfItemsInSection(), 1)
    }
    
    func test_didSelectItemAt_no_movie_data() {
        presenter.viewDidLoad()
        presenter.fetchNowPlayingMovies(result: .failure(AFError.invalidURL(url: "")))
        presenter.didSelectItemAt(index: 0)
        XCTAssertFalse(router.isRouteSearch)
    }
    
    func test_didSelectRowAt_no_movie_data() {
        presenter.viewDidLoad()
        presenter.fetchNowPlayingMovies(result: .failure(AFError.invalidURL(url: "")))
        presenter.didSelectRowAt(index: 0)
        XCTAssertFalse(router.isRouteSearch)
    }
    
    func test_navigate_detail_with_table_view_selection() {
        presenter.viewDidLoad()
        presenter.fetchNowPlayingMovies(result: .success(createListResponse()))
        presenter.didSelectRowAt(index: 0)
        XCTAssertTrue(router.isRouteDetail)
    }
    
    func test_navigate_detail_with_collection_view_selection() {
        presenter.viewDidLoad()
        presenter.fetchUpComingMovies(result: .success(createListResponse()))
        presenter.didSelectItemAt(index: 0)
        XCTAssertTrue(router.isRouteDetail)
    }
    
    func test_navigate_search_view_with_search_view_typing() {
        presenter.viewDidLoad()
        presenter.searchMovie(searchText: "Her şey için teşekkürler Kerim Hocam :)")
        XCTAssertTrue(router.isRouteSearch)
    }
    
    // MARK: - Private Methods
    private func createListResponse() -> ListResponse {
        .init(
            dates: .init(
                maximum: "maximum",
                minimum: "minimum"),
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
final class MockListViewController: ListViewControllerProtocol {
    
    var isCalledReloadData = false
    var isCalledShowLoading = false
    var isCalledHideLoading = false
    var isCalledSetupSearchView = false
    var isCalledSetupCollectionView = false
    var isCalledSetupTableView = false
    var isCalledSetupView = false
    
    func reloadData() {
        isCalledReloadData = true
    }
    
    func showLoadingView() {
        isCalledShowLoading = true
    }
    
    func hideLoadingView() {
        isCalledHideLoading = true
    }
    
    func setupSearchView() {
        isCalledSetupSearchView = true
    }
    
    func setupCollectionView() {
        isCalledSetupCollectionView = true
    }
    
    func setupTableView() {
        isCalledSetupTableView = true
    }
    
    func setUpView() {
        isCalledSetupView = true
    }
}

final class MockListInteractor: ListInteractorProtocol {
    
    var isFetchUpComingMoviesCalled = false
    var isFetchNowPlayingMoviesCalled = false
    
    func fetchUpComingMovies() {
        isFetchUpComingMoviesCalled = true
    }
    
    func fetchNowPlayingMovies() {
        isFetchNowPlayingMoviesCalled = true
    }
}

final class MockListRouter: ListRouterProtocol {
    
    var isRouteDetail = false
    var isRouteSearch = false
    
    func navigate(_ route: ListRoutes) {
        switch route {
        case .detail(_):
            isRouteDetail = true
        case .search(_):
            isRouteSearch = true
        }
    }
}
