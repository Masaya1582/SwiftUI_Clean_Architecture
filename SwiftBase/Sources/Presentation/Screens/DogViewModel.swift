//
//  DogViewModel.swift
//  SwiftBase
//
//  Created by Cookie-san on 2025/08/07.
//

import Foundation
import SwiftUI

@MainActor
final class DogViewModel: ObservableObject {
    @Published var dogs: [Dog] = []
    @Published var isLoading = false
    @Published var error: String?

    private let useCase: DogUseCase

    init(useCase: DogUseCase) {
        self.useCase = useCase
    }

    func loadBreeds() async {
        do {
            isLoading = true
            dogs = try await useCase.execute()
            error = nil
        } catch {
            error = error.localizedDescription
        }
        isLoading = false
    }
}
