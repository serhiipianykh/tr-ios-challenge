//
//  MoviesService.swift
//  TradeRev MovieDB
//
//  Created by Serhii Pianykh on 2020-12-16.
//

import Foundation

enum APIError: Error {
  case invalidResponse
  case noData
  case failedRequest
  case invalidData
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from the server"
        case .noData:
            return "No data received from the server"
        case .failedRequest:
            return "Failed to perform a request"
        case .invalidData:
            return "Couldn't decode data received from the server"
        }
    }
}

class MoviesService {
    typealias MoviesDataCompletion<T> = (T?, APIError?) -> ()
    
    private static let baseURL = "https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master"
    private static let list = "/list"
    private static let details = "/details"
    private static let recommended = "\(details)/recommended"
    
    static func getMoviesList(completion: @escaping MoviesDataCompletion<[Movie]>) {
        let url = URL(string: "\(baseURL)\(list).json")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
              guard error == nil else {
                print("Failed request from Movies API: \(error!.localizedDescription)")
                completion(nil, .failedRequest)
                return
              }
              
              guard let data = data else {
                print("No data returned from Movies API")
                completion(nil, .noData)
                return
              }
              
              guard let response = response as? HTTPURLResponse else {
                print("Unable to process Movies API response")
                completion(nil, .invalidResponse)
                return
              }
              
              guard response.statusCode == 200 else {
                print("Failure response from Movies API: \(response.statusCode)")
                completion(nil, .failedRequest)
                return
              }
              
              do {
                let decoder = JSONDecoder()
                let movies: MoviesData = try decoder.decode(MoviesData.self, from: data)
                completion(movies.movies, nil)
              } catch {
                print("Unable to decode Movies API response: \(error.localizedDescription)")
                completion(nil, .invalidData)
              }
            }
          }.resume()
    }
}
