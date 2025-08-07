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
            let container = AppDIContainer(dogApiKey: "")
            let viewModel = DogViewModel(useCase: container.dogContainer.dogUseCase)
            DogListView(viewModel: viewModel)
        }
    }
}
