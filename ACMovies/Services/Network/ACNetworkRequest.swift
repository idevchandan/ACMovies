//
//  ACNetworkRequest.swift
//  ACMovies
//
//  Created by Chandan Kumar on 30/03/21.
//

import UIKit

class ACNetworkRequest {
    
    static func requestNowPlayingMovieList(completion: @escaping (Result<[ACMovie], ACFetchError>) -> Void) {
        let config = ACApiDataNetworkConfig(baseURL: URL(string: ACTmdbAppConfiguration.apiBaseURL)!,
                                            queryParameters: ["api_key": ACTmdbAppConfiguration.apiKey])
        let nowPlayingMovieListService = ACNetworkService(config: config)
        
        let endPoint = ACAPIEndPoints.nowPlayingMovies()
        
        nowPlayingMovieListService.requestData(with: endPoint) { result in
            switch result {
            case .success(let data):
                do {
                    let movies = try JSONDecoder().decode(ACMovieList.self, from: data)
                    completion(.success(movies.results))
                } catch let error {
                    completion(.failure(error.handleError()))
                }
            case .failure(let error):
                completion(.failure(error.handleError()))
            }
        }
    }
    
    static func requestImage(_ path: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let config = ACApiDataNetworkConfig(baseURL: URL(string: ACTmdbAppConfiguration.imageBaseURL)!)
        
        let fetchImageService = ACNetworkService(config: config)
        
        let endPoint = ACAPIEndPoints.getMovieImage(path: path)
        
        fetchImageService.requestData(with: endPoint) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error.handleError()))
            }
        }
    }
    
}
