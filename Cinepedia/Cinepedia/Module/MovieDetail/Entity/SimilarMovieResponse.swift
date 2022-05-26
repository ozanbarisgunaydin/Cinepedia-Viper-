//
//  SimilarMovieResponse.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 24.04.2022.
//

import Foundation

// MARK: - SimilarMovieResponse
struct SimilarMovieResponse: Codable {
    let page: Int?
    let results: [SimilarMovieOutput]?
    let totalPages, totalResults: Int?
}

// MARK: - SimilarMovieResult
struct SimilarMovieOutput: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let genre_ids: [Int]?
    let id: Int?
    let title: String?
    let original_language: String?
    let original_title, overview: String?
    let popularity: Double?
    let poster_path, release_date: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}
