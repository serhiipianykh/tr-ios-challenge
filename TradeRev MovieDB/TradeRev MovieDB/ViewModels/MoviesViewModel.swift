//
//  MoviesViewModel.swift
//  TradeRev MovieDB
//
//  Created by Serhii Pianykh on 2020-12-16.
// Git

import Foundation


public class MoviesViewModel {

    let movies: Box<[Movie]> = Box([Movie]())
    let pageState: Box<PageState> = Box(PageState.loading)
    
    init() {
        getMovies()
    }
  
    func getMovies() {
        pageState.value = .loading
        MoviesService.getMoviesList { [weak self] (movies, error) in
            guard let self = self else { return }
            guard let movies = movies else {
                self.pageState.value = .failed(error: error)
                return
            }
            self.pageState.value = .loaded
            self.movies.value = movies
        }
    }
}
