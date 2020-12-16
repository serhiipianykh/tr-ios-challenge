//
//  MovieDetailsViewController.swift
//  TradeRev MovieDB
//
//  Created by Serhii Pianykh on 2020-12-16.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    public var movieId: Int?
    public var movieTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = movieTitle
    }

}
