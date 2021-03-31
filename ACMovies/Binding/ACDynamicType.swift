//
//  ACDynamicType.swift
//  ACMovies
//
//  Created by Chandan Kumar on 31/03/21.
//

import Foundation

class ACDynamicType <T> {
    public init() {}

    public var listeners: [(T) -> Void] = []

    public var value: T? {
        didSet {
            for listener in listeners {
                if let value = value {
                    listener(value)
                }
            }
        }
    }
    
    public func bind(listener: @escaping (T) -> Void) {
        listeners.append(listener)
        if let value = value {
            listener(value)
        }
    }
    
}
