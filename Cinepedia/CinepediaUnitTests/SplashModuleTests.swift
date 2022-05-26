//
//  SplashModuleTests.swift
//  CinepediaUnitTests
//
//  Created by Ozan Barış Günaydın on 28.04.2022.
//

import XCTest
@testable import Cinepedia

class SplashScreenTests: XCTestCase {
    
    var presenter: SplashPresenter!
    var view: MockSplashViewController!
    var interactor: MockSplashInteractor!
    var router: MockSplashRouter!
    
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
    
    // MARK: - Private Methods
    func test_internet_connection_method_called_whitout_internet(){
        presenter.viewDidAppear()
        presenter.internetConnection(status: false)
        XCTAssertTrue(view.isNoInternetConnectionCalled)
    }
    
    func test_internet_connection_method_called_with_routeTo_List_whitout_internet(){
        presenter.viewDidAppear()
        presenter.internetConnection(status: false)
        presenter.routeToList()
        XCTAssertTrue(view.isNoInternetConnectionCalled)
    }
    
    func test_internet_connection_method_called_has_internet(){
        presenter.viewDidAppear()
        presenter.internetConnection(status: true)
        XCTAssertFalse(view.isNoInternetConnectionCalled)
    }
    
    func test_interactor_check_internet_method() {
        presenter.viewDidAppear()
        presenter.internetConnection(status: true)
        XCTAssertTrue(interactor.isCheckInternetConnection)
    }
    
    func test_navigate_list_view_controller() {
        presenter.viewDidAppear()
        presenter.internetConnection(status: true)
        presenter.routeToList()
        sleep(1) /// Provides the async after method's code covarege
        XCTAssertTrue(router.isNavigateToListScreen)
    }
    
}


// MARK: - Mock Classes
final class MockSplashViewController: SplashViewControllerProtocol {
    
    var isNoInternetConnectionCalled = false
    
    func noInternetConnection() {
        self.isNoInternetConnectionCalled = true
    }
    
}

final class MockSplashInteractor: SplashInteractorProtocol {
    
    var isCheckInternetConnection = false
    
    func checkInternetConnection() {
        isCheckInternetConnection = true
    }
}

final class MockSplashRouter: SplashRouterProtocol {
    
    var isNavigateToListScreen = false
    
    func navigate(_ route: SplashRoutes) {
        switch route {
        case .listScreen:
            isNavigateToListScreen = true
        }
    }
}
