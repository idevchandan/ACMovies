//
//  ACNetworkError.swift
//  ACMovies
//
//  Created by Chandan Kumar on 30/03/21.
//

import Foundation

enum ACNetworkError: Error {
    case noContentReturned
    case httpError(statusCode: Int)
    case nonFatal(error: Error)

    var message: String {
        switch self {
        case .noContentReturned:
            return "An unknown error occured"
        case .nonFatal(let error):
        return error.localizedDescription
        case .httpError(let statusCode):
            return "\(statusCode) Error occured"
        }
    }
}
