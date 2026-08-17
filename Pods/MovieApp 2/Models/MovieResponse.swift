//
//  MovieResponse.swift
//  MovieApp
//
//  Created by Melike on 21.04.2026.
//
import Alamofire
import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}
