//
//  GenericAPIHTTPRequestMapper.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 18/04/2024.
//

import Foundation

struct GenericAPIHTTPRequestMapper {
    static func map<T>(data: Data, response: HTTPURLResponse) throws -> T where T: Decodable {
        if (200..<300) ~= response.statusCode {
            return try customDateJSONDecoder.decode(T.self, from: data)
        } else if response.statusCode == 401 {
            throw NetworkError.notAuthorized
        } else {
            if let error = try? JSONDecoder().decode(ApiErrorDTO.self, from: data) {
                throw NetworkError.customApiError(error)
            } else {
                throw NetworkError.emptyErrorWithStatusCode(response.statusCode.description)
            }
        }
    }
}

private let customDateJSONDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .custom(customDateDecodingStrategy)
    return decoder
}()

public func customDateDecodingStrategy(decoder: Decoder) throws -> Date {
    let container = try decoder.singleValueContainer()
    let str = try container.decode(String.self)
    return try Date.dateFromString(str)
}
