//
//  MoviesViewController.swift
//  TradeRev MovieDB
//
//  Created by Serhii Pianykh on 2020-12-16.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var refreshControl: UIRefreshControl!
    
    private let viewModel = MoviesViewModel()
    private var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Movies"
        
        self.moviesCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.dataSource = self
        
        self.refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.black
        refreshControl.addTarget(self, action: #selector(refreshMovies), for: .valueChanged)
        self.moviesCollectionView.refreshControl = refreshControl
        
        self.viewModel.movies.bind { [weak self] (movies) in
            guard let self = self else { return }
            self.movies = movies
            self.moviesCollectionView.refreshControl?.endRefreshing()
            self.moviesCollectionView.reloadData()
        }
        
        self.viewModel.pageState.bind { [weak self] (state) in
            guard let self = self else { return }
            self.updateUIForState(state)
        }
    }
    
    @objc private func refreshMovies() {
        self.viewModel.getMovies()
    }
    
    private func updateUIForState(_ state: PageState) {
        switch state {
        case let .failed(error):
            self.activityIndicator.isHidden = true
            self.moviesCollectionView.isHidden = false
            let message = error?.localizedDescription ?? "Failed to load the resource."
            self.showAlert(title: "Error", message: message)
            break
        case .loaded:
            self.activityIndicator.isHidden = true
            self.moviesCollectionView.isHidden = false
            break
        case .loading:
            if movies.isEmpty {
                self.moviesCollectionView.isHidden = true
                self.activityIndicator.isHidden = false
            }
            break
        }
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCellWith(movies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
        let movie = movies[indexPath.item]
        detailsVC.movieTitle = movie.name
        detailsVC.movieId = movie.id
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowLayout?.minimumInteritemSpacing ?? 0.0) + (flowLayout?.sectionInset.left ?? 0.0) + (flowLayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size + 60) // 60 would be a rough height of 2 labels, added to simplify this solution, otherwise could come up with custom flow layout for more accurate sizing
    }
    
    
}
