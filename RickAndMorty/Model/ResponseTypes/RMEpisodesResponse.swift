//
//  RMEpisodesResponse.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 25.02.2024.
//

import Foundation

struct RMEpisodesResponse: Codable {
    let info: RMInfo
    let results: [RMEpisode]
}
