//
//  SearchViewController.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 25.04.2022.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setupTableView()
    func getSearchText() -> String?
}

final class SearchViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var searchText: String?
    var presenter: SearchPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setAccessibilityIdentifiers()
    }
}

extension SearchViewController: SearchViewControllerProtocol, LoadingShowable {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: SearchCell.self)
    }
    
    func getSearchText() -> String? {
        return searchText
    }
    
}

// MARK: - TableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SearchCell.self, for: indexPath)
        cell.selectionStyle = .none
        if let movie = presenter.movie(indexPath.row) {
            cell.cellPresenter = SearchCellPresenter(view: cell, movie: movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }

}

extension SearchViewController {
    func setAccessibilityIdentifiers() {
        tableView.accessibilityIdentifier = "searchTableView"
    }
}
