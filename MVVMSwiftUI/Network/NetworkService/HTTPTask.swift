//
//  HTTPTask.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 18/04/2024.
//

import Foundation

typealias Parameters = [String: Any]

enum HTTPTask {
    case request
    case requestBody(Data)
    case requestUrlParameters(Parameters)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum HTTPStatusCode: Int {
    case ok = 200
    case created = 201
    case accepted = 202
    case noContent = 204

    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405

    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
}
