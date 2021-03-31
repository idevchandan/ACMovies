//
//  Error+ACFetchError.swift
//  ACMovies
//
//  Created by Chandan Kumar on 30/03/21.
//

import Foundation

extension Error {
    
    func handleError() -> ACFetchError {
        guard let networkError = self as? ACNetworkError else {
            return ACFetchError(message: self.localizedDescription)
        }
        return ACFetchError(message: networkError.message)
    }
}
