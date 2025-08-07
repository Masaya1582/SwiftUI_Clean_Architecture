//
//  DogDTO.swift
//  SwiftBase
//
//  Created by Cookie-san on 2025/08/07.
//

import Foundation

struct DogDTO: Decodable {
    let id: Int
    let name: String
    let breedGroup: String?
    let temperament: String?
    let lifeSpan: String
    let image: DogImageDTO?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case breedGroup = "breed_group"
        case temperament
        case lifeSpan = "life_span"
        case image
    }
}

struct DogImageDTO: Decodable {
    let url: String
}

extension DogDTO {
    func toDomain() -> Dog {
        Dog(
            id: id,
            name: name,
            breedGroup: breedGroup,
            temperament: temperament,
            lifeSpan: lifeSpan,
            imageUrl: URL(string: image?.url ?? "")
        )
    }
}
