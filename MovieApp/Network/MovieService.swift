//
//  MovieService.swift
//  MovieApp
//
//  Created by Melike on 17.05.2026.
//

import Foundation
import Alamofire

final class MovieService {
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let url = "\(APIContants.baseURL)/movie/popular"
        
        AF.request(url, headers: APIContants.headers).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do{
                    let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(.success(movieResponse.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

