//
//  Info.swift
//  test
//
//  Created by Arda Büyükhatipoğlu on 1.12.2023.
//

import Foundation

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
