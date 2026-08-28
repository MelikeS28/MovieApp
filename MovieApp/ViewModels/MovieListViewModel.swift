//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Melike on 1.06.2026.
//

import Foundation

final class MovieListViewModel {
    let movieService = MovieService()
    var movies: [Movie] = []
    
    func getMovies(completion: @escaping() -> Void){
        movieService.fetchPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                completion()
            case .failure(let error):
                 print("Error: \(error.localizedDescription)")
            }
        }
    }
}
