//
//  URLRequestBuilder.swift
//  SwiftBase
//
//  Created by Cookie-san on 2025/08/07.
//

import Foundation

enum URLRequestBuilder {
    static func build<T: APIRequest>(from request: T) throws -> URLRequest {
        var urlComponents = URLComponents(url: request.baseURL.appendingPathComponent(request.path), resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = request.queryItems

        guard let finalURL = urlComponents?.url else {
            throw APIError.invalidURL
        }

        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        urlRequest.allHTTPHeaderFields = request.headers
        return urlRequest
    }
}
