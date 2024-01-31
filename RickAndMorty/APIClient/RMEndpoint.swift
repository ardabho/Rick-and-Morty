//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 31.01.2024.
//

import Foundation

/// Represents unique API endpoints
@frozen enum RMEndpoint: String {
    ///Endpoint to get character info
    case character
    ///Endpoint to get location info
    case location
    ///Endpoint to get charachter info
    case episode
}
