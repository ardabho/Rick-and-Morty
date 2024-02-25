//
//  RMEpisodeDetailCollectionViewCellVM.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 25.02.2024.
//

import Foundation

final class RMEpisodeListCollectionViewCellVM {
    let name: String
    let episode: String
    let airDate: String
    
    init(name: String, episode: String, airDate: String) {
        self.name = name
        self.episode = episode
        self.airDate = airDate
    }
}
