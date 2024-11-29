//
//  MoviesService.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 18/04/2024.
//

import Foundation
import Combine

class MoviesService {
    let httpClient: HTTPClientProtocol
    var page: Int = 1
    
    private enum Constants {
        static let apiKey = "564727fa"
    }
    
    private enum MoviesUrl {
        static let movieBaseURL = "https://www.omdbapi.com/?s=${search}&type=movie&apiKey=564727fa"
    }
    
    init(httpClient: HTTPClientProtocol = URLSession.shared) {
        self.httpClient = httpClient
    }
    
    func loadMoviesSearchResult(with search: String) -> AnyPublisher<[MovieDTO], Error> {
        
        guard let request = moviesSearchRequestBuilder(with: search) else {
            return Fail(error: NetworkError.missingURL).eraseToAnyPublisher()
        }
        
        return httpClient
            .publisher(request: request)
            .compactMap { $0.0 }
            .decode(type: MovieListResponse.self, decoder: JSONDecoder())
            .map(\.Search)
            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[MovieDTO], Error> in
                return Just([])
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
    }
    
    private func moviesSearchRequestBuilder(with search: String) -> URLRequest? {
        let urlString = MoviesUrl.movieBaseURL
            .replacingOccurrences(of: "${search}",with: search.lowercased())
            .replacingOccurrences(of: "${page}", with: "\(page)")
            .replacingOccurrences(of: "${key}", with: Constants.apiKey)
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        return URLRequest(url: url)
    }
}
