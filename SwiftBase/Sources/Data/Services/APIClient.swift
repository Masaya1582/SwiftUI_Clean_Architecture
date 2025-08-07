//
//  APIClient.swift
//  SwiftBase
//
//  Created by Cookie-san on 2025/08/07.
//

import Foundation

// MARK: - APIError
enum APIError: Error, LocalizedError {
    case invalidURL
    case responseError(Int, Data?)
    case decodingError
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .responseError(let code, _):
            return "HTTP Error \(code)"
        case .decodingError:
            return "Failed to decode data"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

// MARK: - HTTPMethod
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// MARK: - APIRequest
protocol APIRequest {
    associatedtype Response: Decodable

    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension APIRequest {
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
    var body: Data? { nil }
}

// MARK: - APIClient Protocol
protocol APIClient {
    func send<T: APIRequest>(_ request: T) async throws -> T.Response
}

// MARK: - Default Client
final class Request: APIClient {
    private let session: URLSession
    private let logger: NetworkLogger

    init(session: URLSession = .shared, logger: NetworkLogger = ConsoleLogger()) {
        self.session = session
        self.logger = logger
    }

    func send<T: APIRequest>(_ request: T) async throws -> T.Response {
        let urlRequest = try URLRequestBuilder.build(from: request)
        logger.logRequest(urlRequest, request: request)

        let (data, response) = try await session.data(for: urlRequest)
        logger.logResponse(response, data: data)

        try validateResponse(response, data: data)

        do {
            return try JSONDecoder().decode(T.Response.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }

    private func validateResponse(_ response: URLResponse, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown(NSError(domain: "Invalid response", code: -1))
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw APIError.responseError(httpResponse.statusCode, data)
        }
    }
}
