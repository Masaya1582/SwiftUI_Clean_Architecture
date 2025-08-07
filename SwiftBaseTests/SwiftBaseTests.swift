import Testing
@testable import SwiftBase

extension Dog: Equatable {}

struct DogDTOTests {
    @Test func toDomainConvertsAllFields() {
        let dto = DogDTO(
            id: 1,
            name: "Fido",
            breedGroup: "Herding",
            temperament: "Calm",
            lifeSpan: "10 years",
            image: DogImageDTO(url: "https://example.com/fido.png")
        )

        let dog = dto.toDomain()

        #expect(dog == Dog(
            id: 1,
            name: "Fido",
            breedGroup: "Herding",
            temperament: "Calm",
            lifeSpan: "10 years",
            imageUrl: URL(string: "https://example.com/fido.png")
        ))
    }
}

struct DogUseCaseTests {
    @Test func executeReturnsDogsFromRepository() async throws {
        struct MockDogRepository: DogRepository {
            let result: [Dog]
            func fetchDogs() async throws -> [Dog] { result }
        }

        let expected = [
            Dog(id: 1, name: "Fido", breedGroup: nil, temperament: nil, lifeSpan: "10 years", imageUrl: nil)
        ]

        let useCase = DogUseCaseImpl(repository: MockDogRepository(result: expected))
        let dogs = try await useCase.execute()

        #expect(dogs == expected)
    }
}
