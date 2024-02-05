//
//  RMCharacterDetailVM.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 5.02.2024.
//

import Foundation

final class RMCharacterDetailVM {
    private let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    var nameText: String {
        return character.name.uppercased()
    }
}
