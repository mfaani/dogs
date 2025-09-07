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
//            let httpResponse = response as! HTTPURLResponse
            
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
    case inProgress(Task<UIImage, Error>)
    case completed(UIImage)
}

/// Either gives a failed Image or Good image.
/// Loading state is managed by the view. This is because each view may have a different loading state. (I suppose you could say the same for_failed_ image too. But Loading isn't a response. It's more of an initial state. So that's why I'm keeping them separate...
actor ImageRequester {
    
    private init() {}
    
    /// this to avoid having duplicate cache objects in memory. We should cache the in-memory object **only** once
    static let shared = ImageRequester()
    
    static let failedImage = UIImage()
    
    var cache: [URL: ImageStatus] = [:]
    func getImage(_ url: URL) async -> UIImage {
        var currentTask: Task<UIImage, Error>?
        
        switch cache[url] {
        case .none:
            currentTask = Task<UIImage, Error> {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    return UIImage(data: data) ?? ImageRequester.failedImage
                } catch {
                    return ImageRequester.failedImage
                }
            }
            currentTask.map {
                cache[url] = .inProgress($0)
            }
        case .some(let status):
            switch status {
            case .inProgress(let task):
                currentTask = task
                
            case .completed(let image):
                return image
            }
        }
        guard let currentTask else {
            return ImageRequester.failedImage
        }
        do {
            let image = try await currentTask.value
            return image
        } catch {
            return ImageRequester.failedImage
        }
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
