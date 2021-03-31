//
//  ACDisplayMovieVM.swift
//  ACMovies
//
//  Created by Chandan Kumar on 30/03/21.
//

import Foundation
import UIKit

class ACDisplayMovieVM: NSObject {
    
    var movieTitle: String?
    var imagePath = ""
    var movieImage: UIImage?
    var isFavourite = false
    
    override init() {
        super.init()
    }
    
    init(model: ACMovie) {
        self.movieTitle = model.title
        self.imagePath = model.posterImageURLPath
    }
    
    func fetchMovieImage(_ completion: @escaping (UIImage?) -> Void) {

        ACNetworkRequest.requestImage(imagePath) { result in
            switch result {
            case .success(let image):
                self.movieImage = image
                completion(image)
            case .failure:
                completion(nil)
            }
        }
    }
    
    func saveMovieData() {
        if let movieImageData = self.movieImage?.pngData(), let title = self.movieTitle {
            ACStorageService.shareInstance.saveMovie(title: title, imageData: movieImageData)
        }
    }
}
