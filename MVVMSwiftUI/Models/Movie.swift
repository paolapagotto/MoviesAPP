//
//  Movie.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 15/04/2024.
//

import Foundation

//struct MovieListResponse: Decodable {
//    let Search: [Movie]
//}

struct Movie: Identifiable, Decodable, Hashable {
    
    let imdbId: String
    let title: String
    var poster: URL?
    var followers: Double?
    
    var id: String {
        imdbId
    }
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case poster = "Poster"
        case imdbId = "imdbID"
        case followers = "followers"
    }
}
