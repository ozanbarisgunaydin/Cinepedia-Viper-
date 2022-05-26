//
//  SplashViewController.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 24.04.2022.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
}

class SplashViewController: BaseViewController {
    
    @IBOutlet private weak var splashImage: UIImageView!
    
    var presenter: SplashPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidAppear()
        setAccessibilityIdentifiers()
    }

}

extension SplashViewController: SplashViewControllerProtocol {
    
    func noInternetConnection() {
        showAlert(title: "Connection Error", message: "No Internet Connection. Please check your connection and try again later.")
    }
}

extension SplashViewController {
    func setAccessibilityIdentifiers() {
        splashImage.accessibilityIdentifier = "splashImage"
    }
}
