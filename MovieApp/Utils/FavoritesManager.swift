//
//  FavoritesManager.swift
//  MovieApp
//
//  Created by Melike on 16.06.2026.
//

import Foundation

final class FavoritesManager {
    
    static let shared = FavoritesManager()
    
    private let favoritesKey = "favorite_movies_key"
    
    private init() {}
    
    // MARK: - SaveMovies
    
    private func saveFavoriteMovies(_ movies: [Movie]) {
        
        do {
            let data = try JSONEncoder().encode(movies)
            UserDefaults.standard.set(data, forKey: favoritesKey)
        } catch {
            print("Error saving favorites: \(error)")
        }
    }
    
    // MARK: - GetMovies
    
    func getFavoriteMovies() -> [Movie] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else {
            return []
        }
        
        do{
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            return movies
        } catch {
            print("Error decoding favorites: \(error)")
            return []
        }
     }
    
    // MARK: - AddMovies
    
    func addToFavorites(_ movie: Movie) {
        var currentMovies = getFavoriteMovies()
        
        if currentMovies.contains(where: { $0.id == movie.id}) {
            return
        }
        currentMovies.append(movie)
        saveFavoriteMovies(currentMovies)
    }
    
    // MARK: - RemoveMovies
    
    func removeFromFavorites(_ movie: Movie) {
        var currentMovies = getFavoriteMovies()
        currentMovies.removeAll(where: { $0.id == movie.id})
        saveFavoriteMovies(currentMovies)
    }
}
