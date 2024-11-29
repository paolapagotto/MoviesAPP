//
//  NetworkError.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 15/04/2024.
//

import Foundation

enum NetworkError: LocalizedError {
    case missingURL
    case noConnect
    case notAuthorized
    case invalidData
    case requestFailed
    case encodingError
    case decodingError
    case invalidResponse
    case customApiError(ApiErrorDTO)
    case emptyErrorWithStatusCode(String)
    case error(Error)

    var errorDescription: String? {
        switch self {
        case .missingURL:
            return "Missing URL"
        case .noConnect:
            return "No connect"
        case .notAuthorized:
            return "Invalid Token"
        case .invalidResponse:
            return "Invalid response"
        case .invalidData:
            return "Invalid Data"
        case .decodingError:
            return "Decoding error"
        case .encodingError:
            return "Encoding error"
        case .requestFailed:
            return "Request failed"
        case .customApiError(let apiErrorDTO):
            var errorItems: String?
            if let errorItemsDTO = apiErrorDTO.errorItems {
                errorItems = ""
                errorItemsDTO.forEach {
                    errorItems?.append($0.key)
                    errorItems?.append(" ")
                    errorItems?.append($0.value)
                    errorItems?.append("\n")
                }
            }
            if errorItems == nil && apiErrorDTO.code == nil && apiErrorDTO.message == nil {
                errorItems = "Internal error!"
            }
            return String(format: "%@ %@ \n %@", apiErrorDTO.code ?? "", apiErrorDTO.message ?? "", errorItems ?? "")
        
        case .emptyErrorWithStatusCode(let status):
            return status
            
        case .error(let error):
            return error.localizedDescription
        }
    }
}

struct ApiErrorDTO: Codable {
    let code: String?
    let message: String?
    let errorItems: [String: String]?
}
