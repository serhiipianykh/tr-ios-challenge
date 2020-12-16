//
//  PageState.swift
//  TradeRev MovieDB
//
//  Created by Serhii Pianykh on 2020-12-16.
//

import Foundation

enum PageState {
    case loading
    case loaded
    case failed(error: APIError?)
}

