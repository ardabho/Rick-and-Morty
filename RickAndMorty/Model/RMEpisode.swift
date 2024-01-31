//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 31.01.2024.
//

import Foundation

struct RMEpisode: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode : String
    let characters: [String]
    let url: String
    let created: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name, airDate = "air_date", episode, characters, url, created
    }
}
