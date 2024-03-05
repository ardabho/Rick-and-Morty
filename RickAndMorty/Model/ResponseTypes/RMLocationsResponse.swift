//
//  RMLocationsResponse.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 5.03.2024.
//

import Foundation

struct RMLocationsResponse: Codable {
    let info: RMInfo
    let results: [RMLocation]
}
