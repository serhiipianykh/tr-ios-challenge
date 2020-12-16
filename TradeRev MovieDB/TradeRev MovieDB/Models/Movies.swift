//
//  Movies.swift
//  TradeRev MovieDB
//
//  Created by Serhii Pianykh on 2020-12-16.
//

import Foundation

struct MoviesData: Decodable {
    let movies: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let name: String
    let thumbnail: String
    let year: Int
}

struct MovieDetails: Decodable {
    let id: Int
    let name: String
    let description: String
    let notes: String
    let rating: Float
    let picture: String
    let releaseDate: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, picture, releaseDate
        case description = "Description"
        case notes = "Notes"
        case rating = "Rating"
    }
}
