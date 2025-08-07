//
//  ConsoleLogger.swift
//  SwiftBase
//
//  Created by Cookie-san on 2025/08/07.
//

import Foundation

protocol NetworkLogger {
    func logRequest<T: APIRequest>(_ urlRequest: URLRequest, request: T)
    func logResponse(_ response: URLResponse, data: Data)
}

final class ConsoleLogger: NetworkLogger {
    func logRequest<T: APIRequest>(_ urlRequest: URLRequest, request: T) {
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

    func logResponse(_ response: URLResponse, data: Data) {
        if let httpResponse = response as? HTTPURLResponse {
            print("✅ StatusCode: \(httpResponse.statusCode)")
        }

        if let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) {
            print("📨 Response JSON: \(json)")
        } else {
            print("📨 Response Raw: \(String(data: data, encoding: .utf8) ?? "N/A")")
        }

        print("🏁 ---- End API Request ----\n")
    }
}
