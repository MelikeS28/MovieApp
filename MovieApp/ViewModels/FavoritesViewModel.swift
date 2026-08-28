//
//  FavoritesViewModel.swift
//  MovieApp
//
//  Created by Melike on 16.06.2026.
//

import Foundation

final class FavoritesViewModel {
    
    // MARK: - Properties
    
    static let shared = FavoritesViewModel()
    
    private var favoriteMovies: [Movie] = []
    private let favoritesKey = "saved_favorite_movies"
    
    var numberOfItems: Int {
        return favoriteMovies.count
    }
    
    // MARK: - Initializer
    
    private init() {
        fetchFavoriteMovies()
    }
    
    // MARK: - Data Management
    
    func fetchFavoriteMovies() {
        
        if let data = UserDefaults.standard.data(forKey: favoritesKey) {
                    let decoder = JSONDecoder()
                    if let decodedMovies = try? decoder.decode([Movie].self, from: data) {
                        self.favoriteMovies = decodedMovies
                    }
        }
        
    }
    
    func movie(at index: Int) -> Movie {
        return favoriteMovies[index]
    }
    
    func isMovieFavorite(id: Int) -> Bool {
        return favoriteMovies.contains(where: { $0.id == id })
    }
    
    func toggleFavorite(_ movie: Movie) {
        
        if let index = favoriteMovies.firstIndex(where: { $0.id == movie.id }) {
            favoriteMovies.remove(at: index)
            print("Successfully deleted from local storage: \(movie.title). Remaining Favorites: \(favoriteMovies.count)")
        } else {
           
            var updatedMovie = movie
            updatedMovie.isFavorite = true
            favoriteMovies.append(updatedMovie)
            print("Successfully saved to local storage: \(movie.title). Total Favorites: \(favoriteMovies.count)")
        }
        
        saveToUserDefaults()
        
    }
    
    private func saveToUserDefaults() {
            let encoder = JSONEncoder()
            if let encodedData = try? encoder.encode(favoriteMovies) {
                UserDefaults.standard.set(encodedData, forKey: favoritesKey)
            }
        }
}
