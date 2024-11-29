//
//  MovieListRepository.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 15/04/2024.
//

import Foundation
import Combine

protocol MovieListRepositoryProtocol {
    func loadMoviesSearchResult(with search: String) -> AnyPublisher<[MovieDTO], Error>
}

class MovieListRepository: MovieListRepositoryProtocol {
    private var loadedItens = [MovieDTO]()
    let remoteDataSource: MoviesService

    init(remoteDataSource: MoviesService = MoviesService()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func loadMoviesSearchResult(with search: String) -> AnyPublisher<[MovieDTO], Error> {
        return remoteDataSource.loadMoviesSearchResult(with: search)
    }
}
