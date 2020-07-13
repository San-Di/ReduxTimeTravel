//
//  Movie.swift
//  Redux
//
//  Created by Sandi on 7/12/20.
//  Copyright © 2020 Zenness Evolutionary. All rights reserved.
//

import Foundation

// MARK: - MovieListResponse
struct MovieListResponse: Codable {
    let page, totalResults, totalPages: Int
    let results: [Movie]?

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Movie
struct Movie: Codable {
    let popularity: Double
    let voteCount: Int
    let posterPath: String
    let id: Int
    let originalTitle: String
    let genreIDS: [Int]
    let title: String
    let voteAverage: Double
    let overview, releaseDate: String

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case id
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}
