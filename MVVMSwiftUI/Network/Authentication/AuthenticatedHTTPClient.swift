//
//  AuthenticatedHTTPClient.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 18/04/2024.
//

import Foundation
import Combine

class AuthenticatedHTTPClientDecorator: HTTPClientProtocol {
    
    let client: HTTPClientProtocol
    let tokenProvider: TokenProviderProtocol
    var needsAuthentication: (() -> Void)?
    //let needsAuthentication = PassthroughSubject<Void, Never>() //var needsAuthentication: (() -> Void)?
    
    init(client: HTTPClientProtocol, tokenProvider: TokenProviderProtocol) {
        self.client = client
        self.tokenProvider = tokenProvider
    }
    
    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
        return tokenProvider
            .tokenPublisher()
            .map { token in
                var signedRequest = request
                signedRequest.allHTTPHeaderFields?.removeValue(forKey: "Authorization")
                signedRequest.addValue("Bearer \(token.accessToken)", 
                                       forHTTPHeaderField: "Authorization")
                
                return signedRequest
            }
            .flatMap(client.publisher)
            .handleEvents(receiveCompletion: { [needsAuthentication] completion in
                if case let Subscribers.Completion<Error>.failure(error) = completion,
                   case NetworkError.notAuthorized? = error as? NetworkError {
                    needsAuthentication?()
                    //needsAuthentication.send(())
                }
            })
            .eraseToAnyPublisher()
    }
    
//    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
//        var signedRequest = request
//        signedRequest.allHTTPHeaderFields?.removeValue(forKey: "Authorization")
//        signedRequest.addValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
//
//        return client.publisher(request: signedRequest)
//    }
    
}
