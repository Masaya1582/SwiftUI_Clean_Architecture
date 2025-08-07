//
//  DogUseCase.swift
//  SwiftBase
//
//  Created by Cookie-san on 2025/08/07.
//

import Foundation

protocol DogUseCase {
    func execute() async throws -> [Dog]
}

final class DogUseCaseImpl: DogUseCase {
    private let repository: DogRepository

    init(repository: DogRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Dog] {
        try await repository.fetchDogs()
    }
}
