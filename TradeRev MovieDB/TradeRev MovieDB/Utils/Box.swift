//
//  Box.swift
//  TradeRev MovieDB
//
//  Created by Serhii Pianykh on 2020-12-16.
//

import Foundation

class Box<T> {
    typealias BoxListener = (T) -> Void
    var listener: BoxListener?
    
  
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: BoxListener?) {
        self.listener = listener
        listener?(value)
    }
}
