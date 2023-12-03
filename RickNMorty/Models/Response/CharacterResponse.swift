//
//  CharacterResponse.swift
//  test
//
//  Created by Arda Büyükhatipoğlu on 1.12.2023.
//

import Foundation

struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}

