//
//  TradeRev_MovieDBTests.swift
//  TradeRev MovieDBTests
//
//  Created by Serhii Pianykh on 2020-12-16.
//

import XCTest
@testable import TradeRev_MovieDB

class TradeRev_MovieDBTests: XCTestCase {

    var jsonMovieData: Data!
    var movie: Movie!
    
    var jsonDetailsData: Data!
    var movieDetails: MovieDetails!

    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        let movieUrl = bundle.url(forResource: "MovieTest", withExtension: "json")!
        jsonMovieData = try! Data(contentsOf: movieUrl)
    
        let movieDecoder = JSONDecoder()
        movie = try! movieDecoder.decode(Movie.self, from: jsonMovieData)
        
        let detailsUrl = bundle.url(forResource: "MovieDetailsTest", withExtension: "json")!
        jsonDetailsData = try! Data(contentsOf: detailsUrl)
    
        let detailsDecoder = JSONDecoder()
        movieDetails = try! detailsDecoder.decode(MovieDetails.self, from: jsonDetailsData)
    }
    
    func testDecodeId() throws {
        XCTAssertEqual(movie.id, 123)
    }
      
    func testDecodeName() throws {
        XCTAssertEqual(movie.name, "Fight Club")
    }
    
    func testDecodeYear() throws {
        XCTAssertEqual(movie.year, 1999)
    }
    
    func testDecodeImage() throws {
        XCTAssertEqual(movie.thumbnail, "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.imdb.com%2Ftitle%2Ftt0137523%2F&psig=AOvVaw2hpU5xJuixjfg8VgHORb8e&ust=1608209535124000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCIC8hMPF0u0CFQAAAAAdAAAAABAD")
    }
    
    func testDecodeDetailsId() throws {
        XCTAssertEqual(movieDetails.id, 123)
    }
    
    func testDecodeDetailsName() throws {
        XCTAssertEqual(movieDetails.name, "Fight Club")
    }
    
    func testDecodeDetailsDescription() throws {
        XCTAssertEqual(movieDetails.description, "An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into something much, much more.")
    }
    
    func testDecodeNotesDescription() throws {
        XCTAssertEqual(movieDetails.notes, "An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into something much, much more.")
    }
    
    func testDecodePictureDescription() throws {
        XCTAssertEqual(movieDetails.picture, "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.imdb.com%2Ftitle%2Ftt0137523%2F&psig=AOvVaw2hpU5xJuixjfg8VgHORb8e&ust=1608209535124000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCIC8hMPF0u0CFQAAAAAdAAAAABAD")
    }
    
    func testDecodeReleaseDate() throws {
        XCTAssertEqual(movieDetails.releaseDateTimestamp, 940000898)
    }
    
    func testDecodeReleaseDateConvert() throws {
        XCTAssertEqual(movieDetails.releaseDate, "1999-10-15")
    }
}
