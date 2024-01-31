//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 31.01.2024.
//

import Foundation

struct RMCharacter: Codable {
    let id      : Int
    let name    : String
    let status  : RMStatus
    let species : String
    let type    : String
    let gender  : RMGender
    let origin  : RMSimpleLocation
    let location: RMSimpleLocation
    let image   : String //300x300px
    let episode : [String]
    let url     : String
    let created : String
}
