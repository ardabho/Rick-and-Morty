//
//  RMCharacterPhotoCellVM.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 12.02.2024.
//

import Foundation

struct RMCharacterPhotoCellVM {
    private let imageURL: URL?
    
    init(imageUrl: URL?) {
        self.imageURL = imageUrl
    }
    
    func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        RMImageLoader.shared.downloadImage(imageURL, completion: completion)
    }
}
