//
//  Requester.swift
//  doggs
//
//  Created by mohammad faani on 8/27/25.
//

import Foundation


struct DogsRequester {
    static let apiKey = "live_LdiwWVr6KQ8wxQ8wjX1qMWpxFqx35QN1NkQn44pWVctuBSnmuzroHR0ayHYrfmFA"
    func getDogs(limit: Int = 20) async -> [Dog] {
        // URL
        let urlString = "https://api.thedogapi.com/v1/images/search?limit=\(limit)"
        guard let url = URL(string: urlString) else {
            return []
        }
        
        var request = URLRequest(url: url)
        request.setValue(DogsRequester.apiKey, forHTTPHeaderField: "x-api-key")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            print(String(data: data, encoding: .utf8) ?? "")
            let httpResponse = response as! HTTPURLResponse
            
            let decoded = try JSONDecoder().decode([Dog].self, from: data)
            return decoded
        } catch let error {
            print(error)
            return []
        }
    }
}
import UIKit

enum ImageStatus {
    case inProgress(task: Task<UIImage, Error>)
    case completed(image: UIImage)
}

actor ImageRequester {
    
    static let failedImage = UIImage()
    static let loadingImage = UIImage()
    
    var cache: [URL: ImageStatus] = [:]
    func getImage(_ url: URL) async -> ImageStatus {
        
        switch cache[url] {
        case .none:
            cache[url] = .inProgress(task: <#T##Task<UIImage, any Error>#>)
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
            } catch let error {
                
            }
        case .some(let status):
        }
        return .completed(image: ImageRequester.loadingImage)
    }
}


/*
 must download images.
 must store them in cache
 must be able to retrieve them from cache using ID (ex: URL)
 
 
 
 
 
 BONUS:
 must be able to delete them from cache using ID
 must self-evict upon condition: LRU Cache mechanism I suppose.
 must be able to retrieve from disk
 */
