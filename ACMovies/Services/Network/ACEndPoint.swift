//
//  ACEndPoint.swift
//  ACMovies
//
//  Created by Chandan Kumar on 30/03/21.
//

import Foundation

let kVersion = "3"

final class ACEndPoint {
    let path: String
    let version: String

    init(path: String,
         version: String = kVersion) {
        self.path = path
        self.version = version
    }
}
