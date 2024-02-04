//
//  RMCharacterCollectionViewCellVM.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 3.02.2024.
//

import Foundation

final class RMCharacterCollectionViewCellVM {
    public let characterName: String
    private let characterStatus: RMStatus
    private let characterImageURL: URL?
    
    
    init(characterName: String, characterStatus: RMStatus, imageURL: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = imageURL
    }
    
    
    public var characterStatusText: String {
        return characterStatus.text
    }
    
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}
