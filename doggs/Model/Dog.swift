//
//  Dog.swift
//  doggs
//
//  Created by mohammad faani on 8/29/25.
//


// MARK: - Dog
struct Dog: Codable, Identifiable, Hashable {
    let breeds: [Breed]
    let id: String
    let url: String
    let width, height: Int?
}

// MARK: - Breed
struct Breed: Codable, Hashable, Identifiable {
    struct Image: Codable, Hashable, Identifiable {
        let url: String
        let id: String
    }
    
    let id: Int
    let image: Image
    let name, bredFor, breedGroup, lifeSpan: String?
    let temperament, referenceImageID: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case image
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament
        case referenceImageID = "reference_image_id"
    }
}

// MARK: - Eight
struct Eight: Codable {
    let imperial, metric: String
}

typealias Dogs = [Dog]
