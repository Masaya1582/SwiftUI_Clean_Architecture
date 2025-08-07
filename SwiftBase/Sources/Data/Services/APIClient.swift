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
    case responseError(Int)
    case decodingError
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .responseError(let code): return "HTTP Error \(code)"
        case .decodingError: return "Failed to decode data"
        case .unknown(let error): return error.localizedDescription
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// MARK: - APIRequest Protocol
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

// MARK: - DefaultRequest
final class Request: APIClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func send<T: APIRequest>(_ request: T) async throws -> T.Response {
        let urlRequest = try buildURLRequest(from: request)
        logRequest(urlRequest, for: request)

        let (data, response) = try await session.data(for: urlRequest)
        logResponse(response, data: data)

        try validateResponse(response, data: data)

        do {
            return try JSONDecoder().decode(T.Response.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }

    private func buildURLRequest<T: APIRequest>(from request: T) throws -> URLRequest {
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

    private func logRequest<T: APIRequest>(_ urlRequest: URLRequest, for request: T) {
        print("\n🚀 ---- Start API Request ----")
        print("📍 URL: \(urlRequest.url?.absoluteString ?? "N/A")")
        print("📬 Method: \(urlRequest.httpMethod ?? "N/A")")
        print("📦 Headers: \(urlRequest.allHTTPHeaderFields ?? [:])")

        if let query = request.queryItems {
            print("❓ Query Items: \(query)")
        }

        if let body = request.body,
           let json = try? JSONSerialization.jsonObject(with: body, options: .fragmentsAllowed) {
            print("📤 Body: \(json)")
        }
    }

    private func logResponse(_ response: URLResponse, data: Data) {
        if let httpResponse = response as? HTTPURLResponse {
            print("✅ StatusCode: \(httpResponse.statusCode)")
        }

        if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) {
            print("📨 Response JSON: \(responseJSON)")
        } else {
            print("📨 Response Raw: \(String(data: data, encoding: .utf8) ?? "N/A")")
        }
        print("🏁 ---- End API Request ----\n")
    }

    private func validateResponse(_ response: URLResponse, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown(NSError(domain: "Invalid response", code: -1))
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw APIError.responseError(httpResponse.statusCode)
        }
    }
}
