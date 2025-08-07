//
//  DogRequest.swift
//  SwiftBase
//
//  Created by Cookie-san on 2025/08/07.
//

import Foundation

struct DogRequest: APIRequest {
    typealias Response = [DogDTO]

    var baseURL: URL {
        URL(string: "https://api.thedogapi.com/v1")!
    }

    var path: String { "/breeds" }
    var method: HTTPMethod { .get }

    var apiKey: String

    var headers: [String: String]? {
        [
            "Content-Type": "application/json",
            "x-api-key": apiKey
        ]
    }
}
