//
//  ACMovie.swift
//  ACMovies
//
//  Created by Chandan Kumar on 30/03/21.
//

import Foundation

struct ACMovieList: Codable {
    let results: [ACMovie]
}

struct ACMovie: Codable, Equatable {
    let title: String
    let posterImageURLPath: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case posterImageURLPath = "poster_path"
    }
    
}
