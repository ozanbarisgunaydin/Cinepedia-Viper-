//
//  MovieDetailResponse.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 24.04.2022.
//

import Foundation

// MARK: - MovieDetailResponse
struct MovieDetailResponse: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let belongs_to_collection: BelongsToCollection?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdb_id, original_language, original_title, overview: String?
    let popularity: Double?
    let posterPath: String?
    let production_companies: [ProductionCompany]?
    let production_countries: [ProductionCountry]?
    let release_date: String?
    let revenue, runtime: Int?
    let spoken_languages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
    var favoriteStatus: Bool = false

    enum CodingKeys: String, CodingKey {
        case adult, backdrop_path, belongs_to_collection, budget, genres, homepage, id, imdb_id, original_language, original_title, overview, popularity, posterPath, production_companies, production_countries, release_date, revenue, runtime, spoken_languages, status, tagline, title, video, vote_average, vote_count
    }
}

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int?
    let name, poster_path, backdrop_path: String?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logo_path: String?
    let name, origin_country: String?
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String?
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let english_name, iso639_1, name: String?
}

