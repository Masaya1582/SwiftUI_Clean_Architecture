//
//  DogApiClient.swift
//  SwiftBase
//
//  Created by Cookie-san on 2025/08/07.
//

import Foundation

protocol DogApiClient {
    func fetchAllDogs() async throws -> [DogDTO]
}

final class DogApiClientImpl: DogApiClient {
    private let apiClient: APIClient = Request()
    private let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func fetchAllDogs() async throws -> [DogDTO] {
        let request = DogRequest(apiKey: apiKey)
        return try await apiClient.send(request)
    }
}
