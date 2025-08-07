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
    let breed_group: String?
    let temperament: String?
    let life_span: String
    let image: DogImageDTO?
}

struct DogImageDTO: Decodable {
    let url: String
}

extension DogDTO {
    func toDomain() -> Dog {
        Dog(
            id: id,
            name: name,
            breedGroup: breed_group,
            temperament: temperament,
            lifeSpan: life_span,
            imageUrl: URL(string: image?.url ?? "")
        )
    }
}
