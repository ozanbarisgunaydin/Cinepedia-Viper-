//
//  CinepediaUITests.swift
//  CinepediaUITests
//
//  Created by Ozan Barış Günaydın on 27.04.2022.
//

import XCTest

class CinepediaUITests: XCTestCase {
    
    private var app: XCUIApplication!
       
       override func setUp() {
           super.setUp()
           
           continueAfterFailure = false
           app = XCUIApplication()
           app.launchArguments.append("🚨****** UITest Began ******🚨")
       }
    
    func test_splash_view_controller_exist() {
        app.launch()
        XCTAssertTrue(app.isSplashImageDisplayed)
    }
    
    func test_list_view_controller_elements_exist(){
        app.launch()
        sleep(1)
        XCTAssertTrue(app.isListSearchBarDisplayed)
        XCTAssertTrue(app.isListTableViewDisplayed)
        XCTAssertTrue(app.isListCollectionViewDisplayed)
        XCTAssertTrue(app.isListPageControllerDisplayed)
        XCTAssertTrue(app.isListCellMovieImageDisplayed)
        XCTAssertTrue(app.isListCellTitleYearLabelDisplayed)
        XCTAssertTrue(app.isListCellMovieDescriptionLabelDisplayed)
        XCTAssertTrue(app.isListCellDateLabelDisplayed)
        XCTAssertTrue(app.isBannerImageDisplayed)
        XCTAssertTrue(app.isBannerTitleLabelDisplayed)
    }
    
    func test_not_navigate_search_view_controller_with_2_characters() {
        app.launch()
        sleep(1)
        app.listSearchBar.tap()
        app.typeText("TS")
        sleep(1)
        XCTAssertFalse(app.isSearchTableViewDisplayed)
    }
    
    func test_navigate_search_view_controller_with_more_than_2_characters() {
        app.launch()
        sleep(1)
        app.listSearchBar.tap()
        app.typeText("Oza")
        sleep(1)
        XCTAssertTrue(app.isSearchTableViewDisplayed)
    }
    
    func test_navigate_movie_detail_view_controller_with_search() {
        app.launch()
        app.listSearchBar.tap()
        app.typeText("Prestige")
        app.searchTableView.children(matching: .cell).element(boundBy: 0).tap()
        XCTAssertTrue(app.isMoviePosterImageDisplayed)
        XCTAssertTrue(app.isDetailMovieTitleLabelDisplayed)
        XCTAssertTrue(app.isMovieDescriptionTextViewDisplayed)
        XCTAssertTrue(app.isVoteScoreLabelDisplayed)
        XCTAssertTrue(app.isReleaseDateLabelDisplayed)
        XCTAssertTrue(app.isDetailCollectionViewDisplayed)
        XCTAssertTrue(app.isImdbAvaibleViewDisplayed)
        XCTAssertTrue(app.isAddFavoritesButtonDisplayed)
        XCTAssertTrue(app.isDetailCellMoviePosterImageDisplayed)
        XCTAssertTrue(app.isTitleDateLabelDisplayed)
    }
    
    func test_navigate_movie_detail_view_controller_with_table_view() {
        app.launch()
        app.listTableView.children(matching: .cell).element(boundBy: 2).tap()
        XCTAssertTrue(app.isMoviePosterImageDisplayed)
        XCTAssertTrue(app.isDetailMovieTitleLabelDisplayed)
        XCTAssertTrue(app.isMovieDescriptionTextViewDisplayed)
        XCTAssertTrue(app.isVoteScoreLabelDisplayed)
        XCTAssertTrue(app.isReleaseDateLabelDisplayed)
        XCTAssertTrue(app.isDetailCollectionViewDisplayed)
        XCTAssertTrue(app.isImdbAvaibleViewDisplayed)
        XCTAssertTrue(app.isAddFavoritesButtonDisplayed)
        XCTAssertTrue(app.isDetailCellMoviePosterImageDisplayed)
        XCTAssertTrue(app.isTitleDateLabelDisplayed)
    }
    
    func test_navigate_movie_detail_view_controller_with_collection_view() {
        app.launch()
        app.listCollectionView.cells.element(boundBy: 0).tap()
        XCTAssertTrue(app.isMoviePosterImageDisplayed)
        XCTAssertTrue(app.isDetailMovieTitleLabelDisplayed)
        XCTAssertTrue(app.isMovieDescriptionTextViewDisplayed)
        XCTAssertTrue(app.isVoteScoreLabelDisplayed)
        XCTAssertTrue(app.isReleaseDateLabelDisplayed)
        XCTAssertTrue(app.isDetailCollectionViewDisplayed)
        XCTAssertTrue(app.isImdbAvaibleViewDisplayed)
        XCTAssertTrue(app.isAddFavoritesButtonDisplayed)
        XCTAssertTrue(app.isDetailCellMoviePosterImageDisplayed)
        XCTAssertTrue(app.isTitleDateLabelDisplayed)
    }
 
    func test_navigate_detail_view_controller_with_similar_movie_cell(){
        app.launch()
        app.listCollectionView.cells.element(boundBy: 0).tap()
        app.detailCollectionView.cells.element(boundBy: 0).tap()
        XCTAssertTrue(app.isMoviePosterImageDisplayed)
        XCTAssertTrue(app.isDetailMovieTitleLabelDisplayed)
        XCTAssertTrue(app.isMovieDescriptionTextViewDisplayed)
        XCTAssertTrue(app.isVoteScoreLabelDisplayed)
        XCTAssertTrue(app.isReleaseDateLabelDisplayed)
        XCTAssertTrue(app.isDetailCollectionViewDisplayed)
        XCTAssertTrue(app.isImdbAvaibleViewDisplayed)
        XCTAssertTrue(app.isAddFavoritesButtonDisplayed)
        XCTAssertTrue(app.isDetailCellMoviePosterImageDisplayed)
        XCTAssertTrue(app.isTitleDateLabelDisplayed)
    }
}

extension XCUIApplication {
    
    // MARK: - Splash View Controller
    var splashImage: XCUIElement! {
        images["splashImage"]
    }
    
    var isSplashImageDisplayed: Bool {
        splashImage.exists
    }
    
    // MARK: - List View Controller
    var listSearchBar: XCUIElement! {
        otherElements["listSearchBar"]
    }
    
    var isListSearchBarDisplayed: Bool {
        listSearchBar.exists
    }
    
    var listCollectionView: XCUIElement! {
        collectionViews["listCollectionView"]
    }
    
    var isListCollectionViewDisplayed: Bool {
        listCollectionView.exists
    }
    
    var listPageController: XCUIElement! {
        pageIndicators["listPageController"]
    }
    
    var isListPageControllerDisplayed: Bool {
        listPageController.exists
    }
    
    var listTableView: XCUIElement! {
        tables["listTableView"]
    }
    
    var isListTableViewDisplayed: Bool {
        listTableView.exists
    }
    
    var listCellMovieImage: XCUIElement! {
        images["listCellMovieImage"]
    }
    
    var isListCellMovieImageDisplayed: Bool {
        listCellMovieImage.exists
    }
    
    var listCellTitleYearLabel: XCUIElement! {
        staticTexts.matching(identifier: "listCellTitleYearLabel").element
    }
    
    var isListCellTitleYearLabelDisplayed: Bool {
        listCellTitleYearLabel.exists
    }
    
    var listCellMovieDescriptionLabel: XCUIElement! {
        staticTexts.matching(identifier: "listCellMovieDescriptionLabel").element
    }
    
    var isListCellMovieDescriptionLabelDisplayed: Bool {
        listCellMovieDescriptionLabel.exists
    }
    
    var listCellDateLabel: XCUIElement! {
        staticTexts.matching(identifier: "listCellDateLabel").element
    }
    
    var isListCellDateLabelDisplayed: Bool {
        listCellDateLabel.exists
    }
    
    var bannerImage: XCUIElement! {
        images["bannerImage"]
    }
    
    var isBannerImageDisplayed: Bool {
        bannerImage.exists
    }
    
    var bannerTitleLabel: XCUIElement! {
        staticTexts.matching(identifier: "bannerTitleLabel").element
    }
    
    var isBannerTitleLabelDisplayed: Bool {
        bannerTitleLabel.exists
    }
    
    
    // MARK: - Search View Controller
    var searchTableView: XCUIElement! {
        tables["searchTableView"]
    }
    
    var isSearchTableViewDisplayed: Bool {
        searchTableView.exists
    }
    
    var movieTitleLabel: XCUIElement! {
        staticTexts.matching(identifier: "movieTitleLabel").element
    }
    
    var isMovieTitleLabelDisplayed: Bool {
        movieTitleLabel.exists
    }
    
    // MARK: - Detail View Controller
    
    var moviePosterImage: XCUIElement! {
        images["moviePosterImage"]
    }
    
    var isMoviePosterImageDisplayed: Bool {
        moviePosterImage.exists
    }
    
    var detailMovieTitleLabel: XCUIElement! {
        staticTexts.matching(identifier: "movieTitleLabel").element
    }
    
    var isDetailMovieTitleLabelDisplayed: Bool {
        movieTitleLabel.exists
    }
    
    var movieDescriptionTextView: XCUIElement! {
        textViews["movieDescriptionTextView"]
    }
    
    var isMovieDescriptionTextViewDisplayed: Bool {
        movieDescriptionTextView.exists
    }
    
    var voteScoreLabel: XCUIElement! {
        staticTexts.matching(identifier: "voteScoreLabel").element
    }
    
    var isVoteScoreLabelDisplayed: Bool {
        voteScoreLabel.exists
    }
    
    var releaseDateLabel: XCUIElement! {
        staticTexts.matching(identifier: "releaseDateLabel").element
    }
    
    var isReleaseDateLabelDisplayed: Bool {
        releaseDateLabel.exists
    }
    
    var detailCollectionView: XCUIElement! {
        collectionViews["detailCollectionView"]
    }
    
    var isDetailCollectionViewDisplayed: Bool {
        detailCollectionView.exists
    }
    
    var imdbAvaibleView: XCUIElement! {
        otherElements["imdbAvaibleView"]
    }
    
    var isImdbAvaibleViewDisplayed: Bool {
        imdbAvaibleView.exists
    }
    
    var addFavoritesButton: XCUIElement! {
        buttons["addFavoritesButton"]
    }
    
    var isAddFavoritesButtonDisplayed: Bool {
        addFavoritesButton.exists
    }
    
    var detailCellMoviePosterImage: XCUIElement! {
        images["detailCellMoviePosterImage"]
    }
    
    var isDetailCellMoviePosterImageDisplayed: Bool {
        detailCellMoviePosterImage.exists
    }
    
    var titleDateLabel: XCUIElement! {
        staticTexts.matching(identifier: "detailCellMovieTitleLabel").element
    }
    
    var isTitleDateLabelDisplayed: Bool {
        titleDateLabel.exists
    }
    
}
