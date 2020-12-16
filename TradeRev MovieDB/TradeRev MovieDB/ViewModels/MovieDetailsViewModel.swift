//
//  MovieDetailsViewModel.swift
//  TradeRev MovieDB
//
//  Created by Serhii Pianykh on 2020-12-16.
//

import Foundation

public class MovieDetailsViewModel {

    let name = Box(" ")
    let description = Box(" ")
    let notes = Box(" ")
    let rating = Box(" ")
    let image = Box(" ")
    let releaseDate = Box(" ")
    let recommendedMovies: Box<[Movie]> = Box([Movie]())
    
    
    func loadMovieDetails(id: Int) {
        getMovieDetails(id)
        getRecommendedMovies(id)
    }
    
    private func getMovieDetails(_ id: Int) {
        MoviesService.getMovieDetails(id: id) { [weak self] (details, error) in
            guard let self = self, let details = details else { return }
            self.name.value = details.name
            self.description.value = details.description
            self.notes.value = details.notes
            self.rating.value = "\(details.rating)"
            self.releaseDate.value = details.releaseDate
            self.image.value = details.picture
        }
    }
  
    private func getRecommendedMovies(_ id: Int) {
        MoviesService.getRecommendedFor(id) { [weak self] (movies, error) in
            guard let self = self, let movies = movies else { return }
            self.recommendedMovies.value = movies
        }
    }
}
