//
//  SwiftBaseApp.swift
//  SwiftBase
//
//  Created by Cookie-san on 2025/08/07.
//

import SwiftUI

@main
struct SwiftBaseApp: App {
    var body: some Scene {
        WindowGroup {
            let useCase = DogDIContainer.shared.dogUseCase
            let viewModel = DogViewModel(useCase: useCase)
            DogListView(viewModel: viewModel)
        }
    }
}
