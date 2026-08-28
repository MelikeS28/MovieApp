//
//  APIContants.swift
//  MovieApp
//
//  Created by Melike on 17.05.2026.
//

import Foundation
import Alamofire

enum APIContants {
    
    // MARK: - URLs
        
        static let baseURL = "https://api.themoviedb.org/3"
        static let imageBaseURL = "https://image.tmdb.org/t/p/"
        
        // MARK: - Image Sizes
        
        static let bigposterSizeW1280 = "w1280"
        static let mediumposterSizeW500 = "w500"
        
        // MARK: - API Key & Headers
        
        private static var bearerToken: String {
            guard let token = Bundle.main.object(forInfoDictionaryKey: "TMDBBearerToken") as? String else {
                fatalError("TMDB Bearer Token missing in Info.plist / Secrets.xcconfig")
            }
            return token
        }
        
        static var headers: HTTPHeaders {
            return [
                "accept": "application/json",
                "Authorization": "Bearer \(bearerToken)"
            ]
        }
    
}
