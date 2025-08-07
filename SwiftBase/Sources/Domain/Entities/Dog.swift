//
//  Dog.swift
//  SwiftBase
//
//  Created by Cookie-san on 2025/08/07.
//

import Foundation

struct Dog: Identifiable {
    let id: Int
    let name: String
    let breedGroup: String?
    let temperament: String?
    let lifeSpan: String
    let imageUrl: URL?
}
