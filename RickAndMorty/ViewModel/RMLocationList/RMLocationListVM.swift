//
//  RMLocationListVM.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 5.03.2024.
//

import Foundation

final class RMLocationListVM {
    
    private var locations: [RMLocation] = []
    
    //Location response info
    //Will contain next url, if present
    
    private var cellViewModels: [String] = []
    
    private var hasMoreResults: Bool {
        return false
    }
    
    init() {}
    

    func fetchLocations() {
        
        RMService.shared.execute(.listLocationsRequests, expecting: RMLocationsResponse.self) { result in
            switch result {
            case .success(let model):
                print(String(describing: model))
            case .failure(let error):
                break
            }
        }
    }
}
