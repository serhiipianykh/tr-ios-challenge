//
//  MoviesViewController.swift
//  TradeRev MovieDB
//
//  Created by Serhii Pianykh on 2020-12-16.
//

import UIKit

class MoviesViewController: UIViewController {
    
    private var movies = [Movie]()

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Movies"
        
        self.moviesCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.dataSource = self
        
        //dummy data
        movies.append(Movie(id: 1, name: "Fight Club", thumbnail: "https://upload.wikimedia.org/wikipedia/en/f/fc/Fight_Club_poster.jpg", year: 1999))
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
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size + 60) // 60 would be a rough height of 2 labels, added to simplify this solution, otherwise could come up with custom flow layout for more accurate sizing
    }
    
    
}
