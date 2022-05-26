//
//  MovieDetailViewController.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 26.04.2022.
//

import UIKit
import SDWebImage

protocol MovieDetailViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setUpView()
    func setupCollectionView()
    func setMoviePoster(_ imageUrl: URL)
    func setMovieTitle(_ text: String)
    func setMovieDescription(_ text: String)
    func setVoteScore(_ text: String)
    func setReleaseDate(_ text: String)
    func setFavoritesButton(_ text: String, isAdded: Bool)
    func setImdbAvaibleView()
    func getMovieId() -> Int?
}

class MovieDetailViewController: UIViewController {
    
    @IBOutlet private weak var moviePosterImage: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieDescriptionTextView: UITextView!
    @IBOutlet private weak var voteScoreLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var imdbAvaibleView: UIView! {
        didSet {
            imdbAvaibleView.isHidden = true
        }
    }
    @IBOutlet private weak var addFavoritesButton: UIButton! {
        didSet {
            addFavoritesButton.layer.cornerRadius = 8
            addFavoritesButton.layer.borderWidth = 1
            addFavoritesButton.layer.borderColor = UIColor.lightGray.cgColor
            addFavoritesButton.backgroundColor = .systemYellow
            addFavoritesButton.tintColor = .black
        }
    }
    
    var movieId: Int?
    var presenter: MovieDetailPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction func didTapImdb(_ sender: Any) {
        presenter.goToImdbPage()
    }
    
    @IBAction func didTapAddFavorites(_ sender: Any) {
        presenter.addFavoritesButtonTapped(movieID: self.movieId ?? 0)
    }
    
}

// MARK: - MovieDetailViewControllerProtocol
extension MovieDetailViewController: MovieDetailViewControllerProtocol, LoadingShowable {
    
    func setMoviePoster(_ imageUrl: URL) {
        moviePosterImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_movie_poster"))
    }
    
    func setMovieTitle(_ text: String) {
        movieTitleLabel.text = text
    }
    
    func setMovieDescription(_ text: String) {
        movieDescriptionTextView.text = text
    }
    
    func setVoteScore(_ text: String) {
        voteScoreLabel.text = text
    }
    
    func setReleaseDate(_ text: String) {
        releaseDateLabel.text = text
    }
    
    func setFavoritesButton(_ text: String, isAdded: Bool) {
        addFavoritesButton.setTitle(text, for: .normal)
        addFavoritesButton.backgroundColor = isAdded ? .lightGray : .systemYellow
        addFavoritesButton.tintColor = isAdded ? .white : .black
    }
    
    func setImdbAvaibleView() {
        imdbAvaibleView.isHidden = false
    }
    
    func reloadData() {
        self.presenter.loadInputViews()
        collectionView.reloadData()
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: SimilarMovieCell.self)
        
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
    }
    
    func setUpView() {
        setAccessibilityIdentifiers()
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func getMovieId() -> Int? {
        return movieId
    }
}

// MARK: - CollectionView (Banner)
extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: SimilarMovieCell.self, for: indexPath)
        if let similarMovie = presenter.similarMovie(indexPath.row) {
            cell.cellPresenter = SimilarMovieCellPresenter(view: cell, movie: similarMovie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(index: indexPath.row)
    }
}

extension MovieDetailViewController {
    func setAccessibilityIdentifiers() {
        moviePosterImage.accessibilityIdentifier = "moviePosterImage"
        movieTitleLabel.accessibilityIdentifier = "movieTitleLabel"
        movieDescriptionTextView.accessibilityIdentifier = "movieDescriptionTextView"
        voteScoreLabel.accessibilityIdentifier = "voteScoreLabel"
        releaseDateLabel.accessibilityIdentifier = "releaseDateLabel"
        collectionView.accessibilityIdentifier = "detailCollectionView"
        imdbAvaibleView.accessibilityIdentifier = "imdbAvaibleView"
        addFavoritesButton.accessibilityIdentifier = "addFavoritesButton"
    }
}
