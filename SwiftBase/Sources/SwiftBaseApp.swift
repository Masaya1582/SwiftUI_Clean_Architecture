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
            let container = DogDIContainer(apiKey: "")
            let viewModel = DogViewModel(useCase: container.dogUseCase)
            DogListView(viewModel: viewModel)
        }
    }
}
