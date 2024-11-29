//
//  NetworkService.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 15/04/2024.
//

import Foundation
import Combine

public class HTTPClient {
    
    var page: Int = 3
    private enum Constants {
        static let apiKey = "564727fa"
    }
    
    private enum HTTPUrl {
        static let movieBaseURL = "https://www.omdbapi.com/?s=${search}&type=movie&apiKey=${key}"
    }
    
    func fetchItemsFromURL(with search: String) -> AnyPublisher<[MovieDTO], Error> {
        
        let urlString = HTTPUrl.movieBaseURL.replacingOccurrences(
            of: "${search}",
            with: search.lowercased()).replacingOccurrences(
                of: "${page}",
                with: "\(page)").replacingOccurrences(
                    of: "${key}",
                    with: Constants.apiKey)
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.missingURL).eraseToAnyPublisher()
        }
       
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieListResponse.self, decoder: JSONDecoder())
            .map(\.Search)
            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[MovieDTO], Error> in
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
