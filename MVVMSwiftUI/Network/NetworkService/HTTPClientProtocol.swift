//
//  HTTPClientProtocol.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 18/04/2024.
//

import Foundation
import Combine

protocol HTTPClientProtocol {
    ///Just make the Request with Foundation types: Combine
    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error>
    
    ////Just make the Request with Foundation types: Async/Await
    //func publisher(request: URLRequest) async throws -> (Data, HTTPURLResponse)
}

extension URLSession: HTTPClientProtocol {
    
    struct InvalidHTTPResponseError: Error { }
    
    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), any Error> {
        return dataTaskPublisher(for: request).tryMap({ result in
            guard let httpResponse = result.response as? HTTPURLResponse else {
                throw InvalidHTTPResponseError()
            }
            return (result.data, httpResponse)
        })
        .eraseToAnyPublisher()
    }
    
    func publisher(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, httpResponse) = try await data(for: request)
        
        guard let httpResponse = httpResponse as? HTTPURLResponse else {
            throw InvalidHTTPResponseError()
        }
        return (data, httpResponse)
    }
}
