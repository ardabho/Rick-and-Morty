//
//  RMLocationListVM.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 5.03.2024.
//

import Foundation

protocol RMLocationListVMDelegate: AnyObject {
    func didFinishFetchingInitialLocations()
}


final class RMLocationListVM {
    
    private var locations: [RMLocation] = [] {
        didSet {
            for location in locations {
                let cellVM = RMLocationCellVM(location: location)
                if !cellViewModels.contains(cellVM) {
                    cellViewModels.append(cellVM)
                }
                
            }
        }
    }
    
    private var apiInfo: RMInfo? //Location response info, will contain next url, if present
    
    private(set) var cellViewModels: [RMLocationCellVM] = []
    
    private var hasMoreResults: Bool {
        return false
    }
    
    weak var delegate: RMLocationListVMDelegate?
    
    init() {}
    
    func getLocation(for index: Int) -> RMLocation? {
        guard index < locations.count else { return nil }
        return locations[index]
    }
    
    
    func fetchLocations() {
        
        RMService.shared.execute(.listLocationsRequests, expecting: RMLocationsResponse.self) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let model):
                self.apiInfo = model.info
                self.locations = model.results
                
                DispatchQueue.main.async {
                    self.delegate?.didFinishFetchingInitialLocations()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
