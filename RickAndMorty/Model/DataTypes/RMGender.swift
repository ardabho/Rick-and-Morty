//
//  RMGender.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 31.01.2024.
//

import Foundation

enum RMGender: String, Codable {
    case female     = "Female"
    case male       = "Male"
    case genderless = "Genderless"
    case unknown    = "unknown"
    
    var text: String {
        switch self {
        case .female, .male, .genderless:
            return self.rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
