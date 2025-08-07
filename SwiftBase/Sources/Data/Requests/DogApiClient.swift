//
//  DogApiClient.swift
//  SwiftBase
//
//  Created by Cookie-san on 2025/08/07.
//

import Foundation

// MARK: - Protocol
protocol DogApiClient {
    func fetchAllDogs() async throws -> [DogDTO]
}

// MARK: - Implementation
final class DogApiClientImpl: DogApiClient {
    private let apiClient: APIClient
    private let apiKey: String

    init(apiClient: APIClient = Request(), apiKey: String) {
        self.apiClient = apiClient
        self.apiKey = apiKey
    }

    func fetchAllDogs() async throws -> [DogDTO] {
        try await send(DogRequest(apiKey: apiKey))
    }

    // MARK: - Private
    private func send<T: APIRequest>(_ request: T) async throws -> T.Response {
        try await apiClient.send(request)
    }
}
