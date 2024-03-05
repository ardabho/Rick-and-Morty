//
//  RMLocationCellVM.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 5.03.2024.
//

import Foundation

struct RMLocationCellVM: Hashable, Equatable {
    
    private let location: RMLocation
    
    init(location: RMLocation) { self.location = location }
    
    var name      : String { return location.name }
    var type      : String { return location.type }
    var dimension : String { return location.dimension }
    
    static func == (lhs: RMLocationCellVM, rhs: RMLocationCellVM) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(location.id)
        hasher.combine(name)
    }
}
