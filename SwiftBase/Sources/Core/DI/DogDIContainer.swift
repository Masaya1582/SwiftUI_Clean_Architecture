//
//  DogDIContainer.swift
//  SwiftBase
//
//  Created by Cookie-san on 2025/08/07.
//

import Foundation

final class DogDIContainer {
    let dogApiClient: DogApiClient
    let dogRepository: DogRepository
    let dogUseCase: DogUseCase

    init(apiKey: String, apiClient: APIClient = Request()) {
        let dogClient = DogApiClientImpl(apiClient: apiClient, apiKey: apiKey)
        self.dogApiClient = dogClient
        self.dogRepository = DogRepositoryImpl(apiClient: dogClient)
        self.dogUseCase = DogUseCaseImpl(repository: dogRepository)
    }
}
