//
//  RMInfo.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 1.02.2024.
//

import Foundation

struct RMInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
