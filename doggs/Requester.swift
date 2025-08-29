//
//  Requester.swift
//  doggs
//
//  Created by mohammad faani on 8/27/25.
//

import Foundation


class Requester {
    
    func getDogs() async -> [Dog] {
        // URL
        let urlString = "https://api.thedogapi.com/v1/breeds?api_key=live_LdiwWVr6KQ8wxQ8wjX1qMWpxFqx35QN1NkQn44pWVctuBSnmuzroHR0ayHYrfmFA?limit=5"
        guard let url = URL(string: urlString) else {
            return []
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
//            print(String(data: data, encoding: .utf8) ?? "")
            
            let decoded = try JSONDecoder().decode(Dogs.self, from: data)
            return decoded
        } catch let error {
            print(error)
            return []
        }
    }
}

// MARK: - WelcomeElement
struct Dog: Codable {
    let weight, height: Eight
    let id: Int
    let name, lifeSpan: String
    let breedGroup: String?
    let bredFor: String?
    let temperament: String?
    let referenceImageID: String
    let origin: String?
    let image: Image
    let countryCode: String?

    enum CodingKeys: String, CodingKey {
        case weight, height, id, name
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament, origin
        case referenceImageID = "reference_image_id"
        case image
        case countryCode = "country_code"
    }
}

// MARK: - Eight
struct Eight: Codable {
    let imperial, metric: String
}

// MARK: - Image
struct Image: Codable {
    let id: String
    let width, height: Int
    let url: String
}

typealias Dogs = [Dog]
