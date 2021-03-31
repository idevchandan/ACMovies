//
//  ACNetworkConfig.swift
//  ACMovies
//
//  Created by Chandan Kumar on 30/03/21.
//

import Foundation

public protocol ACNetworkConfig {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}

public struct ACApiDataNetworkConfig: ACNetworkConfig {
    public let baseURL: URL
    public let headers: [String: String]
    public let queryParameters: [String: String]

     public init(baseURL: URL,
                 headers: [String: String] = [:],
                 queryParameters: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
