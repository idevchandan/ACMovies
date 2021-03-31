//
//  ACAPIEndPoints.swift
//  ACMovies
//
//  Created by Chandan Kumar on 30/03/21.
//

import Foundation

let kDEFAULT_IMAGE_WIDTH = 200

struct ACAPIEndPoints {

    static func nowPlayingMovies() -> ACEndPoint {
        return ACEndPoint(path: "movie/now_playing")
    }

    static func getMovieImage(path: String) -> ACEndPoint {
        return ACEndPoint(path: "t/p/w\(kDEFAULT_IMAGE_WIDTH)/\(path)", version: "")
    }
}
