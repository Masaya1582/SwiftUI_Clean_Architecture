//
//  DogRepository.swift
//  SwiftBase
//
//  Created by Cookie-san on 2025/08/07.
//

import Foundation

protocol DogRepository {
    func fetchDogs() async throws -> [Dog]
}

final class DogRepositoryImpl: DogRepository {
    private let apiClient: DogApiClient

    init(apiClient: DogApiClient) {
        self.apiClient = apiClient
    }

    func fetchDogs() async throws -> [Dog] {
        let dtos = try await apiClient.fetchAllDogs()
        return dtos.map { $0.toDomain() }
    }
}
