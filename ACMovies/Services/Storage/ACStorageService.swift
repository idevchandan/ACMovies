//
//  ACStorageService.swift
//  ACMovies
//
//  Created by Chandan Kumar on 31/03/21.
//

import UIKit
import CoreData

class ACStorageService {
    
    static let shareInstance = ACStorageService()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveMovie(title: String, imageData: Data) {
        let movieInstance = FavouriteMovie(context: context)
        movieInstance.title = title
        movieInstance.image = imageData
            
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchFavouriteMovies() -> [FavouriteMovie] {
        var fetchingMovie = [FavouriteMovie]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteMovie")
        
        do {
            fetchingMovie = try context.fetch(fetchRequest) as! [FavouriteMovie]
        } catch {
            print("Error while fetching the Movie")
        }
        
        return fetchingMovie
    }
}

