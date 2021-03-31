//
//  ACMovieTabbarController.swift
//  ACMovies
//
//  Created by Chandan Kumar on 30/03/21.
//

import UIKit

class ACMovieTabbarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewControllers = [nowPlayingMovieTabBar, favouriteMovieTabBar]
        self.view.backgroundColor = .white
    }
    
    lazy public var nowPlayingMovieTabBar: ACNowPlayingMovieController = {
        
        let movieTabBar = ACNowPlayingMovieController()
        
        let title = "Movies"
        
        let defaultImage = UIImage(systemName: "star")
        
        let selectedImage = UIImage(systemName: "star.fill")
        
        movieTabBar.tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        
        return movieTabBar
    }()
    
    lazy public var favouriteMovieTabBar: ACFavouriteMovieController = {
        
        let favouriteTabBar = ACFavouriteMovieController()
        
        let title = "Favourite"
        
        let defaultImage = UIImage(systemName: "heart")
        
        let selectedImage = UIImage(systemName: "heart.fill")
        
        favouriteTabBar.tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        
        return favouriteTabBar
    }()
    
}
