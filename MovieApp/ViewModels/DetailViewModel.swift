//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Melike on 15.06.2026.
//

import Foundation

final class DetailViewModel {
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var titleMovie: String {
        return movie.title ?? "Unknown Movie"
    }
    var raitingMovie: String {
        return String(format: "★ %.1f", movie.voteAverage ?? 0.0)
    }
    var overviewMovieText: String {
        return movie.overview ?? "No overview available for this movie."
    }
    var posterURL: URL? {
        if let path = movie.posterPath {
            return URL(string: APIContants.imageBaseURL + APIContants.bigposterSizeW1280 + path)
        }
        return nil
    }
}
