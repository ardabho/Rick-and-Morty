//
//  RMEpisodeDetailVM.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 17.02.2024.
//

import Foundation

final class RMEpisodeDetailVM {
    
    private let endpointURL: URL?
    
    init(url: URL?) {
        self.endpointURL = url
        fetchEpisodeData()
    }
    
    
    private func fetchEpisodeData() {
        guard let url = endpointURL, let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
        
    }
    
}
