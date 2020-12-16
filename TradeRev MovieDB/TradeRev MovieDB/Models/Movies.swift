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
    
    private static let dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    let id: Int
    let name: String
    let description: String
    let notes: String
    let rating: Float
    let picture: String
    let releaseDateTimestamp: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case description = "Description"
        case notes = "Notes"
        case rating = "Rating"
        case releaseDateTimestamp = "releaseDate"
    }
    
    var releaseDate: String {
        let date = Date(timeIntervalSince1970: TimeInterval(releaseDateTimestamp))
        return Self.dateFormatter.string(from: date)
    }
}
