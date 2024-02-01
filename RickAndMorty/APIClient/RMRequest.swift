//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 31.01.2024.
//

import Foundation

/// Object that represents a single API Call
final class RMRequest {
    
    private struct Constants { static let baseUrl = "https://rickandmortyapi.com/api" }
    private let endpoint: RMEndpoint
    private let pathComponents: Set<String>
    private let queryParameters: [URLQueryItem]
    
    ///Constructed url for the api request in string format
    private var urlString: String {
        var string = Constants.baseUrl + "/" + endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of path components
    ///   - queryParameters: Collection of query parameters
    public init(endpoint: RMEndpoint, pathComponents: Set<String> = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
}
