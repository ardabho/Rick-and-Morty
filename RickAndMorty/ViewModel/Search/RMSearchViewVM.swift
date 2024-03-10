//
//  RMSearchViewVM.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 10.03.2024.
//

import Foundation

// Responsibilities
// - show search results
// - show no results view
// - kick off API requests

struct RMSearchViewVM {
    let config: SearchCategory
    
    init(config: SearchCategory) {
        self.config = config
    }
}
