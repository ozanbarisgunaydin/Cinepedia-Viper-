//
//  ListResponse.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 24.04.2022.
//

import Foundation

// MARK: - ListResponse
/// Both now playing and up coming lists uses same data structure (model).
struct ListResponse: Codable {
    let dates: Dates?
    let page: Int?
    let results: [ListResult]?
    let total_pages, total_results: Int?
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}

// MARK: - NowPlayingResult
struct ListResult: Codable{
    let adult: Bool?
    let backdrop_path: String?
    let genre_ids: [Int]?
    let id: Int?
    let original_language: String?
    let original_title, overview: String?
    let popularity: Double?
    let poster_path, release_date, title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}
