//
//  RMCharacterListViewVM.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 2.02.2024.
//

import UIKit

final class RMCharacterListViewVM: NSObject {
    
    func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequests, expecting: RMCharactersResponse.self) { result in
            switch result {
            case .success(let characters):
                print("characters success")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension RMCharacterListViewVM: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.identifier, for: indexPath) as? RMCharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUpCell(with: RMCharacterCollectionViewCellVM(characterName: "Rick Sanchez", characterStatus: .alive, imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/215.jpeg")))
        return cell
    }
    
    
}
