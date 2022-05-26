//
//  MovieDetailModuleTests.swift
//  CinepediaUnitTests
//
//  Created by Ozan Barış Günaydın on 28.04.2022.
//

import XCTest
@testable import Cinepedia
@testable import Alamofire

class MovieDetailModuleTests: XCTestCase {

    var presenter: MovieDetailPresenter!
    var view: MockMovieDetailViewController!
    var interactor: MockMovieDetailInteractor!
    var router: MockLMovieDetailRouter!
    
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
    func test_viewDidLoad_Invoke_setup_views() {
        presenter.viewDidLoad()
        XCTAssertTrue(view.isCalledSetupCollectionView)
        XCTAssertTrue(view.isCalledSetupView)
    }
    
    func test_view_methods_with_no_data() {
        presenter.viewDidLoad()
        
        presenter.fetchMovieDetail(result: .failure(AFError.invalidURL(url: "")))
        presenter.fetchSimilarMovies(result: .failure(AFError.invalidURL(url: "")))
        
        XCTAssertTrue(view.isCalledHideLoading)
        XCTAssertFalse(view.isCalledReloadData)
        
        XCTAssertTrue(interactor.isCalledFetchMovieDetail)
        XCTAssertTrue(interactor.isCalledSimilarMovies)

        XCTAssertEqual(presenter.numberOfItemsInSection(), 0)
        XCTAssertEqual(presenter.similarMovie(0)?.id, nil)
        
        XCTAssertFalse(view.isCalledSetMoviePoster)
        XCTAssertFalse(view.isCalledSetMovieTitle)
        XCTAssertFalse(view.isCalledSetReleaseDate)
        XCTAssertFalse(view.isCalledSetVoteScore)
        XCTAssertFalse(view.isCalledSetMovieDescription)
        XCTAssertFalse(view.isCalledSetFavoritesButton)
        XCTAssertFalse(view.isCalledSetImdbAvaibleView)
    }
    
    func test_viewDidLoad_Invoke_Fetch_Datas_Succes_Status_Empty_Data() {
        presenter.viewDidLoad()
        
        presenter.fetchMovieDetail(result: .success(createEmptyMovieDetailResponse()))
        presenter.fetchSimilarMovies(result: .success(createEmptySimilarMovieResponse()))
        
        XCTAssertTrue(interactor.isCalledFetchMovieDetail)
        XCTAssertTrue(interactor.isCalledSimilarMovies)
        
        XCTAssertTrue(view.isCalledHideLoading)
        XCTAssertTrue(view.isCalledReloadData)
        
        XCTAssertEqual(presenter.numberOfItemsInSection(), 0)
        XCTAssertEqual(presenter.similarMovie(0)?.id, nil)
        
        XCTAssertFalse(view.isCalledSetMoviePoster)
        XCTAssertFalse(view.isCalledSetMovieTitle)
        XCTAssertFalse(view.isCalledSetReleaseDate)
        XCTAssertFalse(view.isCalledSetVoteScore)
        XCTAssertFalse(view.isCalledSetMovieDescription)
        XCTAssertFalse(view.isCalledSetFavoritesButton)
        XCTAssertFalse(view.isCalledSetImdbAvaibleView)
    }
    
    func test_viewDidLoad_Invoke_Fetch_Datas_Succes_Status_Filled_Data() {
        presenter.viewDidLoad()
        
        presenter.fetchMovieDetail(result: .success(createMovieDetailResponse()))
        presenter.fetchSimilarMovies(result: .success(createSimilarMovieResponse()))
                
        XCTAssertTrue(view.isCalledHideLoading)
        XCTAssertTrue(view.isCalledReloadData)
        presenter.loadInputViews()
        XCTAssertTrue(interactor.isCalledFetchMovieDetail)
        XCTAssertTrue(interactor.isCalledSimilarMovies)
        
        XCTAssertEqual(presenter.numberOfItemsInSection(), 1)
        XCTAssertEqual(presenter.similarMovie(0)?.id, 61)
        
        XCTAssertTrue(view.isCalledSetMoviePoster)
        XCTAssertTrue(view.isCalledSetMovieTitle)
        XCTAssertTrue(view.isCalledSetReleaseDate)
        XCTAssertTrue(view.isCalledSetVoteScore)
        XCTAssertTrue(view.isCalledSetMovieDescription)
        XCTAssertTrue(view.isCalledSetFavoritesButton)
        XCTAssertTrue(view.isCalledSetImdbAvaibleView)
    }
    
    func test_didSelectItemAt_with_no_date() {
        presenter.viewDidLoad()
        presenter.fetchMovieDetail(result: .failure(AFError.invalidURL(url: "")))
        presenter.didSelectItemAt(index: 0)
        XCTAssertFalse(router.isCalledRouteDetail)
    }
    
    func test_addFavoritesButton() {
        presenter.viewDidLoad()
        presenter.fetchMovieDetail(result: .success(createMovieDetailResponse()))
        presenter.addFavoritesButtonTapped(movieID: 1)
        XCTAssertTrue(view.isCalledSetFavoritesButton)
        XCTAssertEqual(UserDefaults.standard.integer(forKey: "1"), 1) /// Adds the user defaults, because of the favorite status is false by default
        presenter.addFavoritesButtonTapped(movieID: 1)
        XCTAssertTrue(view.isCalledSetFavoritesButton)
        XCTAssertNotEqual(UserDefaults.standard.integer(forKey: "1"), 1) /// Removes the value at the second time. Like user tap again and unfollow movie cause the removing from favorites
        presenter.addFavoritesButtonTapped(movieID: 1)
        XCTAssertTrue(view.isCalledSetFavoritesButton)
        XCTAssertEqual(UserDefaults.standard.integer(forKey: "1"), 1)
    }
    
    func test_navigate_detail_movie_with_similar_movie() {
        presenter.viewDidLoad()
        presenter.fetchSimilarMovies(result: .success(createSimilarMovieResponse()))
        presenter.didSelectItemAt(index: 0)
        XCTAssertTrue(router.isCalledRouteDetail)
    }
    
    func test_navigate_imdb_web_page() {
        presenter.viewDidLoad()
        presenter.fetchMovieDetail(result: .success(createMovieDetailResponse()))
        presenter.goToImdbPage()
        XCTAssertTrue(router.isCalledOpenUrl)
    }

// MARK: - Private Methods
    private func createEmptySimilarMovieResponse() -> SimilarMovieResponse {
        .init(page: nil, results: nil, totalPages: nil, totalResults: nil)
    }
    
    private func createSimilarMovieResponse() -> SimilarMovieResponse {
        .init(
            page: 1,
            results:
                [.init(
                    adult: false,
                    backdrop_path: "backdrop_path",
                    genre_ids: [1],
                    id: 61,
                    title: "title",
                    original_language: "original_language",
                    original_title: "original_title",
                    overview: "overview",
                    popularity: 1.0,
                    poster_path: "poster_path",
                    release_date: "release_date",
                    video: false,
                    vote_average: 1.0,
                    vote_count: 1
                )],
            totalPages: 1,
            totalResults: 1
        )
    }
    
    private func createEmptyMovieDetailResponse() -> MovieDetailResponse {
        .init(adult: nil, backdrop_path: nil, belongs_to_collection: nil, budget: nil, genres: nil, homepage: nil, id: nil, imdb_id: nil, original_language: nil, original_title: nil, overview: nil, popularity: nil, posterPath: nil, production_companies: nil, production_countries: nil, release_date: nil, revenue: nil, runtime: nil, spoken_languages: nil, status: nil, tagline: nil, title: nil, video: nil, vote_average: nil, vote_count: nil)
    }
    
    private func createMovieDetailResponse() -> MovieDetailResponse {
        .init(
            adult: false,
            backdrop_path: "backdrop_path",
            belongs_to_collection: .init(
                id: 61,
                name: "name",
                poster_path: "poster_path",
                backdrop_path: "backdrop_path"
            ),
            budget: 1,
            genres: [.init(
                id: 1,
                name: "name"
            )],
            homepage: "homepage",
            id: 1,
            imdb_id: "imdb_id",
            original_language: "original_language",
            original_title: "original_title",
            overview: "overview",
            popularity: 1.0,
            posterPath: "posterPath",
            production_companies: [.init(
                id: 1,
                logo_path: "logo_path",
                name: "name",
                origin_country: "origin_country"
            )],
            production_countries: [.init(
                iso3166_1: "iso3166_1",
                name: "name"
            )],
            release_date: "release_date",
            revenue: 1,
            runtime: 1,
            spoken_languages: [.init(
                english_name: "english_name",
                iso639_1: "iso639_1",
                name: "name"
            )],
            status: "status",
            tagline: "tagline",
            title: "title",
            video: true,
            vote_average: 1.0,
            vote_count: 1
        )
    }
}

// MARK: - Mock Classes
final class MockMovieDetailViewController: MovieDetailViewControllerProtocol {
    
    var isCalledReloadData = false
    var isCalledShowLoading = false
    var isCalledHideLoading = false
    var isCalledSetupCollectionView = false
    var isCalledSetupView = false
    var isCalledSetMoviePoster = false
    var isCalledSetMovieTitle = false
    var isCalledSetMovieDescription = false
    var isCalledSetVoteScore = false
    var isCalledSetReleaseDate = false
    var isCalledSetFavoritesButton = false
    var isCalledSetImdbAvaibleView = false
    var isCalledGetMovieId = false
    
    func reloadData() {
        isCalledReloadData = true
    }
    
    func showLoadingView() {
        isCalledShowLoading = true
    }
    
    func hideLoadingView() {
        isCalledHideLoading = true
    }
    
    func setupCollectionView() {
        isCalledSetupCollectionView = true
    }
    
    func setUpView() {
        isCalledSetupView = true
    }
    
    func setMoviePoster(_ imageUrl: URL) {
        isCalledSetMoviePoster = true
    }
    
    func setMovieTitle(_ text: String) {
        isCalledSetMovieTitle = true
    }
    
    func setMovieDescription(_ text: String) {
        isCalledSetMovieDescription = true
    }
    
    func setVoteScore(_ text: String) {
        isCalledSetVoteScore = true
    }
    
    func setReleaseDate(_ text: String) {
        isCalledSetReleaseDate = true
    }
    
    func setFavoritesButton(_ text: String, isAdded: Bool) {
        isCalledSetFavoritesButton = true
    }
    
    func setImdbAvaibleView() {
        isCalledSetImdbAvaibleView = true
    }
    
    func getMovieId() -> Int? {
        isCalledGetMovieId = true
        return 0
    }
    
}

final class MockMovieDetailInteractor: MovieDetailInteractorProtocol {
    
    var isCalledFetchMovieDetail = false
    var isCalledSimilarMovies = false
    
    func fetchMovieDetail(_ movieId: Int) {
        isCalledFetchMovieDetail = true
    }
    
    func fetchSimilarMovies(_ movieId: Int) {
        isCalledSimilarMovies = true
    }
}

final class MockLMovieDetailRouter: MovieDetailRouterProtocol {
    
    var isCalledRouteDetail = false
    var isCalledOpenUrl = false
    
    func navigate(_ route: MovieDetailRoutes) {
        switch route {
        case .detail(_):
            isCalledRouteDetail = true
        case .openURL(_):
            isCalledOpenUrl = true
        }
    }
}
