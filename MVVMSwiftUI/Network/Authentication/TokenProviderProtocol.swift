//
//  TokenProviderProtocol.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 18/04/2024.
//

import Foundation
import Combine

protocol TokenProviderProtocol {
    func tokenPublisher() -> AnyPublisher<AuthenticationDTO, Error>
}
