//
//  DogListView.swift
//  SwiftBase
//
//  Created by Cookie-san on 2025/08/07.
//

import SwiftUI

struct DogListView: View {
    @StateObject var viewModel: DogViewModel

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading breeds...")
                } else if let error = viewModel.error {
                    Text("Error: \(error)")
                } else {
                    List(viewModel.dogs) { dog in
                        HStack(alignment: .top) {
                            AsyncImage(url: dog.imageUrl) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                case .failure:
                                    Image(systemName: "photo")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            VStack(alignment: .leading) {
                                Text(dog.name)
                                    .font(.headline)
                                if let temperament = dog.temperament {
                                    Text(temperament)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Text("Lifespan: \(dog.lifeSpan)")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .onAppear {
                viewModel.loadBreeds()
            }
            .navigationTitle("Dog Breeds")
        }
    }
}
