//
//  DogDIContainer.swift
//  SwiftBase
//
//  Created by Cookie-san on 2025/08/07.
//

import Foundation

final class DogDIContainer {
    static let shared = DogDIContainer()

    let dogApiClient: DogApiClient
    let dogRepository: DogRepository
    let dogUseCase: DogUseCase

    private init() {
        let apiKey = ""
        let dogClient = DogApiClientImpl(apiKey: apiKey)
        self.dogApiClient = dogClient
        self.dogRepository = DogRepositoryImpl(apiClient: dogClient)
        self.dogUseCase = DogUseCaseImpl(repository: dogRepository)
    }
}
