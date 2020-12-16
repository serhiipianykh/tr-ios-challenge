//
//  MovieDetailsViewController.swift
//  TradeRev MovieDB
//
//  Created by Serhii Pianykh on 2020-12-16.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var recommendedCollectionView: UICollectionView!
    
    
    public var movieId: Int?
    public var movieTitle: String?
    
    private let viewModel = MovieDetailsViewModel()
    private var recommendedMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = movieTitle
        
        setViewModelListeners()
        
        recommendedCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecommendedMovieCollectionViewCell")
        recommendedCollectionView.delegate = self
        recommendedCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let id = movieId {
            viewModel.loadMovieDetails(id: id)
        }
    }
    
    private func setViewModelListeners() {
        viewModel.name.bind { [weak self] (name) in
            guard let self = self else { return }
            self.titleLabel.text = name
        }
        viewModel.image.bind { [weak self] (image) in
            guard let self = self else { return }
            if let url = URL(string: image) {
                self.posterImageView.load(url: url, placeholder: nil)
            }
        }
        viewModel.releaseDate.bind { [weak self]  (releaseDate) in
            guard let self = self else { return }
            self.releaseDateLabel.text = releaseDate
        }
        viewModel.rating.bind { [weak self] (rating) in
            guard let self = self else { return }
            self.ratingLabel.text = "\(rating)"
        }
        viewModel.description.bind { [weak self] (desc) in
            guard let self = self else { return }
            self.descriptionLabel.text = desc
        }
        viewModel.notes.bind { [weak self] (notes) in
            guard let self = self else { return }
            self.notesLabel.text = notes
        }
        viewModel.recommendedMovies.bind { [weak self] (movies) in
            guard let self = self else { return }
            self.recommendedMovies = movies
            self.recommendedCollectionView.reloadData()
        }
    }

}

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedMovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCellWith(recommendedMovies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
        let movie = recommendedMovies[indexPath.item]
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
        let height = collectionView.frame.size.height
        let width = height - 60 // 60 would be a rough height of 2 labels, added to simplify this solution, otherwise could come up with custom flow layout for more accurate sizing
        return CGSize(width: width, height: height) 
    }
    
}
