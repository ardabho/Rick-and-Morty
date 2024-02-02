//
//  RMCharacterResponse.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 1.02.2024.
//

import Foundation

struct RMCharactersResponse: Codable {
    let info: RMInfo
    let results: [RMCharacter]
}

