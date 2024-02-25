//
//  RMEpisodeListCollectionViewCellVM.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 25.02.2024.
//

import UIKit

final class RMEpisodeListCollectionViewCellVM: Hashable, Equatable {
    
    let name: String
    let episode: String
    let airDate: String
    let borderColor: UIColor
    
    init(name: String, episode: String, airDate: String) {
        self.name = name
        self.episode = episode
        self.airDate = airDate
        self.borderColor = UIHelper.borderColors.randomElement() ?? .systemBlue
    }
    
    
    static func == (lhs: RMEpisodeListCollectionViewCellVM, rhs: RMEpisodeListCollectionViewCellVM) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(episode)
        hasher.combine(airDate)
    }
    
}
