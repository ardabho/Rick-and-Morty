//
//  RMService.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 31.01.2024.
//

import Foundation

/// Primary API Service Object to get Rick and Morty data
final class RMService {
    
    /// Shared singleton instance
    static let shared = RMService()
    
    private let cacheManager = RMAPICacheManager()
    
    /// Privatized constructor
    private init() {}
    
    
    /// Custom errors for service
    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    
    /**
     Executes a network request and handles the response asynchronously.

     - Parameters:
        - request: An optional `RMRequest` object representing the request to be executed.
        - type: The type of the expected response, conforming to `Codable`.
        - completion: A closure to be called once the request completes, containing a `Result` enum with either the decoded response of type `T` or an error.

     - Note:
        The function first attempts to retrieve cached data for the given request. If cached data exists, it decodes it using the provided type and returns it immediately.
    */
    public func execute<T: Codable>(_ request: RMRequest?, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request else { return }
        
        //Check if the data is cached and return cache data if it exists
        if let cachedData = cacheManager.cachedResponse(for: request.endpoint, url: URL(string: request.urlString)) {
            if let result = try? JSONDecoder().decode(type.self, from: cachedData) {
                completion(.success(result))
                return
            }
        }
        
        guard let urlRequest = request.urlRequest else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) {[weak self] data, _, error in
            
            guard let data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(for: request.endpoint, url: URL(string: request.urlString), data: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
