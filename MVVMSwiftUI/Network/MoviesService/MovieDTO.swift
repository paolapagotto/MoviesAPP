//
//  MovieDTO.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 18/04/2024.
//

import Foundation

struct MovieListResponse: Decodable {
    let Search: [MovieDTO]
}

struct MovieDTO: Identifiable, Decodable, Hashable {
    
    let imdbId: String
    let title: String?
    var poster: URL?
    var thumbnailURL: URL?
    let year: String?
    var followers: Double?
    
    var id: String {
        imdbId
    }
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case poster = "Poster"
        case imdbId = "imdbID"
        case year = "Year"
        case followers = "followers"
    }
}
