//
//  ACNowPlayingMovieController.swift
//  MoviesNowPlaying
//
//  Created by Chandan Kumar on 30/03/21.
//

final class ACNowPlayingMovieController: ACMovieDisplayController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchNowPlayingMovieList()
    }
    
    private func bindToViewModel() {
        viewModel.viewState.bind { [weak self] movieListState in
            guard let self = self else { return }

            switch movieListState {
            case .loading:
                self.loadingView.startAnimatingIndicator()
                self.emptyStateView.removeView()
            case .finishedLoading:
                self.loadingView.stopAnimatingIndicator()
                self.emptyStateView.removeView()
                self.reloadMovieList()
            case .error(error: let errorString):
                self.loadingView.stopAnimatingIndicator()
                self.emptyStateView.showView(with: errorString)
            }
        }
    }
    
    
    
}
