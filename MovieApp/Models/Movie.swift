//
//  Movie.swift
//  MovieApp
//
//  Created by Melike on 21.04.2026.
//

import Foundation

struct Movie: Decodable, Encodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double
    
    var isFavorite: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
    var postURL: URL? {
        guard let posterPath = posterPath else { return nil }
        
        let urlString = APIContants.imageBaseURL + APIContants.mediumposterSizeW500 + posterPath
        return URL(string: urlString)
    }
    
}
