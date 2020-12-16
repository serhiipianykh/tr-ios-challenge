//
//  UIImageView+Cache.swift
//  TradeRev MovieDB
//
//  Created by Serhii Pianykh on 2020-12-16.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL, placeholder: UIImage?) {
        let request = URLRequest(url: url)
        if let data = URLCache.shared.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            self.image = placeholder
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    URLCache.shared.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }).resume()
        }
    }
}
