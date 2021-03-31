//
//  ACMovieDisplayController.swift
//  MoviesNowPlaying
//
//  Created by Chandan Kumar on 30/03/21.
//

import UIKit
import Masonry

let kMOVIE_DISPALY_CELL_REUSE_IDENTIFIER = "movieDisplayCellIdentifier"

class ACMovieDisplayController : UIViewController {
    
    var viewModel = ACNowPlayingMovieListVM()
    
    lazy var movieListView: UICollectionView = {
        let listView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        listView.contentInset = UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
        listView.translatesAutoresizingMaskIntoConstraints = false
        listView.register(ACMovieDisplayCell.self, forCellWithReuseIdentifier: kMOVIE_DISPALY_CELL_REUSE_IDENTIFIER)
        listView.showsVerticalScrollIndicator = false
        listView.dataSource = self
        listView.delegate = self
        listView.backgroundColor = UIColor.systemGray6
        return listView
    }()
    
    let loadingView: ACLoadingView = {
        let loadingView = ACLoadingView()
        return loadingView
    }()
    
    let emptyStateView: ACEmptyStateView = {
        let emptyStateView = ACEmptyStateView()
        return emptyStateView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        setUpConstraints()
    }
    
    func addSubView() {
        self.view.addSubview(movieListView)
        self.view.addSubview(loadingView)
        self.view.addSubview(emptyStateView)
    }
    
    func setUpConstraints() {
        movieListView.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(view.mas_safeAreaLayoutGuideTop)?.offset()(10)
            make?.leading.equalTo()(view.mas_leading)
            make?.trailing.equalTo()(view.mas_trailing)
            make?.bottom.equalTo()(view.mas_safeAreaLayoutGuideBottom)?.offset()(10)
        }
        
        loadingView.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.edges.equalTo()(view)
        }
        
        emptyStateView.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.edges.equalTo()(view)
        }
    }
    
    func reloadMovieList() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.movieListView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, sizeForItemAtIndexPath indexPath: IndexPath) -> (width: CGFloat, height: CGFloat) {
        let insets = collectionView.contentInset
        let cellWidth: CGFloat = UIScreen.main.bounds.size.width - (insets.left + insets.right)
        var movieListIndex = 0
        if (self.tabBarController?.selectedIndex == 1) {
            movieListIndex = 1
        }
        return viewModel.sizeForItem(atIndexPath: indexPath, itemWidth: cellWidth, index: movieListIndex)
    }
    
}

extension ACMovieDisplayController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.tabBarController?.selectedIndex == 0) {
            return self.viewModel.movies.count
        } else {
            return self.viewModel.favouriteMovies.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectinoViewSizeAtIndexPath = self.collectionView(movieListView, sizeForItemAtIndexPath: indexPath)
        return CGSize(width: collectinoViewSizeAtIndexPath.width - 5, height: collectinoViewSizeAtIndexPath.height)
    }
    
}

extension ACMovieDisplayController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell:ACMovieDisplayCell = collectionView.dequeueReusableCell(withReuseIdentifier: kMOVIE_DISPALY_CELL_REUSE_IDENTIFIER, for: indexPath) as! ACMovieDisplayCell
        if (self.tabBarController?.selectedIndex == 0) {
            movieCell.movieCellVM = self.viewModel.movies[indexPath.item]
        } else {
            movieCell.movieCellVM = self.viewModel.favouriteMovies[indexPath.item]
        }
        return movieCell
    }
    
}

