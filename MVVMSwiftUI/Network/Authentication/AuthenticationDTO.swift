//
//  AuthenticationDTO.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 18/04/2024.
//

import Foundation

struct AuthenticationDTO: Codable {
    let accessToken: String
    let expiresIn, refreshExpiresIn: Int
    let refreshToken, tokenType: String
    let notBeforePolicy: Int
    let sessionState, scope: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshExpiresIn = "refresh_expires_in"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case notBeforePolicy = "not-before-policy"
        case sessionState = "session_state"
        case scope
    }
}

struct TokenModel: Codable {
    let exp: Double
    let name: String?
    let given_name: String?
    let family_name: String?
}
