//
//  ACNowPlayingMovieListVM.swift
//  ACMovies
//
//  Created by Chandan Kumar on 30/03/21.
//

import Foundation
import UIKit

enum ACMovieListViewState: Equatable {
    static func == (lhs: ACMovieListViewState, rhs: ACMovieListViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.finishedLoading, .finishedLoading):
            return true
        case (.error(let errorLHS), .error(let errorRHS)):
            return errorLHS == errorRHS
        default:
            return false
        }
    }

    case loading
    case finishedLoading
    case error(error: String)
}


class ACNowPlayingMovieListVM: NSObject {
    var movies: [ACDisplayMovieVM] = []
    
    var favouriteMovies: [ACDisplayMovieVM] = []
    
    var viewState: ACDynamicType<ACMovieListViewState> = ACDynamicType<ACMovieListViewState>()
    
    func fetchNowPlayingMovieList() {
        ACNetworkRequest.requestNowPlayingMovieList { [weak self] movieResult in
            guard let self = self else { return }

            switch movieResult {
            case .success(let movies):
                self.movies.removeAll()
                for movie in movies {
                    self.movies.append(ACDisplayMovieVM(model: movie))
                }
                self.viewState.value = .finishedLoading
            case .failure(let error):
                self.viewState.value = .error(error: error.message)
            }
        }
    }
    
    func fetchFavouriteMovieList(completion: @escaping (_ movieList: Array<Any>) -> Void) {
        let movieList = ACStorageService.shareInstance.fetchFavouriteMovies()
        
        self.favouriteMovies.removeAll()
        if  movieList.count > 0 {
            for movie in movieList {
                let favouritMovie = ACDisplayMovieVM()
                favouritMovie.isFavourite = true
                favouritMovie.movieTitle = movie.title
                favouritMovie.movieImage = UIImage(data: movie.image!)
                self.favouriteMovies.append(favouritMovie)
            }
        }
        completion(self.favouriteMovies)
    }
    
    func sizeForItem(atIndexPath path:IndexPath, itemWidth width:CGFloat, index: Int) -> (width: CGFloat, height: CGFloat) {
        
        let cellVM: ACDisplayMovieVM?
        if (index == 0) {
        cellVM = movies[path.item]
        } else {
            cellVM = favouriteMovies[path.item]
        }
        let imageHeight: CGFloat = 150.0
        var titleHeight: CGFloat = 0.0
        
        let cellWidth = width / 2.0
        
        if let title = cellVM?.movieTitle {
            titleHeight = heightForLabel(text: title, font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold), width: cellWidth)
        }
        
        let cellHeight = imageHeight + titleHeight + 25
        return (cellWidth, cellHeight)
    }
    
    private func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: (width - 15), height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
    
}
