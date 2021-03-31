//
//  ACFavouriteMovieController.swift
//  MoviesNowPlaying
//
//  Created by Chandan Kumar on 30/03/21.
//

final class ACFavouriteMovieController: ACMovieDisplayController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavouriteMovieList { movieList in
            let favouriteMovies = movieList
            if favouriteMovies.count > 0 {
                self.emptyStateView.removeView()
                self.loadingView.stopAnimatingIndicator()
                self.reloadMovieList()
            } else {
                self.emptyStateView.showView(with: "Please select your Favourite movie.")
            }
        }
    }
    
}
