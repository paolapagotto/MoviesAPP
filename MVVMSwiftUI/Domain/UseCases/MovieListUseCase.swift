//
//  MovieListUseCase.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 15/04/2024.
//

import Foundation
import Combine

protocol MovieListUseCaseProtocol {
    var repository: MovieListRepositoryProtocol { get }
    func loadMovies(with search: String) -> AnyPublisher<[MovieDTO], Error>
}

class MovieListUseCase: MovieListUseCaseProtocol {
    var repository: MovieListRepositoryProtocol
    
    init(repository: MovieListRepositoryProtocol = MovieListRepository()) {
        self.repository = repository
    }

    func loadMovies(with search: String) -> AnyPublisher<[MovieDTO], Error>  {
        return repository.loadMoviesSearchResult(with: search)
    }
}
