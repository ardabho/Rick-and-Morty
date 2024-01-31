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
    
    
    /// Privatized constructor
    private init() {}
    
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request Instance
    ///   - completion: Callback with data or error
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {
        
    }
}
