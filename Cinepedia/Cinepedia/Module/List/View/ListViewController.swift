//
//  ListViewController.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 24.04.2022.
//

import UIKit

protocol ListViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setupSearchView()
    func setupCollectionView()
    func setupTableView()
    func setUpView()
}

final class ListViewController: BaseViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageController: UIPageControl!
    @IBOutlet private weak var tableView: UITableView!
        
    var presenter: ListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    @IBAction func pageControllerAction(_ sender: Any) {
        self.collectionView.scrollToItem(at: IndexPath(row: (sender as AnyObject).currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
}

// MARK: - ListViewControllerProtocol
extension ListViewController: ListViewControllerProtocol, LoadingShowable {
    
    func reloadData() {
        collectionView.reloadData()
        pageController.numberOfPages = presenter.numberOfItemsInSection()
        tableView.reloadData()
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func setupSearchView() {
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.showsCancelButton = true
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: MovieBannerCell.self)
        
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: MovieListCell.self)
    }
    
    func setUpView() {
        setAccessibilityIdentifiers()
        self.navigationController?.navigationBar.tintColor = .black
    }

}

extension ListViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let topVC = self.navigationController?.topViewController {
            
            if topVC.children.count > 0 {
                let viewControllers: [UIViewController] = topVC.children
                viewControllers.last?.removeFromParent()
                viewControllers.last?.view.removeFromSuperview()
            }
        }
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        workItem.perform(after: 0.5) {
            
            self.presenter.searchMovie(searchText: searchText)
        }
    }
}

// MARK: - CollectionView (Banner)
extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: MovieBannerCell.self, for: indexPath)
        if let banner = presenter.banner(indexPath.row) {
            cell.cellPresenter = MovieBannerCellPresenter(view: cell, movie: banner)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            self.pageController.currentPage = indexPath.row
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 200.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        swipePageControl()
    }
    
    /// Better scrolling on the pager
    private func swipePageControl() {
        let visibleRect: CGRect = .init(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        pageController.currentPage = visibleIndexPath.row
    }
    
}

// MARK: - TabeView (List)
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: MovieListCell.self, for: indexPath)
        cell.selectionStyle = .none
        if let movie = presenter.movie(indexPath.row) {
            cell.cellPresenter = MovieListCellPresenter(view: cell, movie: movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
    
}

extension ListViewController {
    func setAccessibilityIdentifiers() {
        searchBar.accessibilityIdentifier = "listSearchBar"
        collectionView.accessibilityIdentifier = "listCollectionView"
        pageController.accessibilityIdentifier = "listPageController"
        tableView.accessibilityIdentifier = "listTableView"
    }
}



