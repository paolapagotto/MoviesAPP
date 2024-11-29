//
//  ContentViewModel.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 15/04/2024.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var movies: [MovieDTO] = []
    @Published var search: String = ""
    
    var searchSubject = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let useCase: MovieListUseCaseProtocol
    
    init(useCase: MovieListUseCaseProtocol = MovieListUseCase()) {
        self.useCase = useCase
    }
    
    func setupSearchPublisher() {
        searchSubject
            .eraseToAnyPublisher()
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .share()
            .flatMap({ [useCase] searchInput in
                useCase.loadMovies(with: searchInput)
                    .catch({ error -> Just<[MovieDTO]> in
                        return Just([])
                    })
                    .eraseToAnyPublisher()
            })
            .assign(to: &$movies)
    }
    
    func generateRandomMovie() {
        searchSubject.send(buildRandomString(strLen: 2))
    }
    
    private func buildRandomString(strLen: Int) -> String {
       let chars = "abcdefghijklmnopqrstuvwxyz"
       let resStr = String((0..<strLen).map{_ in chars.randomElement()!})
       return resStr
    }
    
//    func setupSearchPublisher() {
//        searchSubject.debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
//            .sink(receiveCompletion: { _ in
//                
//            }, receiveValue: { search in
//                self.loadItems(with: search)
//            })
//            .store(in: &cancellables)
//    }
//    
//    func loadItems(with search: String) {
//
//        useCase?.loadMovies(with: search)
//            .sink { _ in
//                
//            } receiveValue: { items in
//                self.movies = items
//                
//            }.store(in: &cancellables)
//    }
    
}
