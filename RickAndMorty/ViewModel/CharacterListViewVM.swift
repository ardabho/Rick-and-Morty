//
//  CharacterListViewVM.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 2.02.2024.
//

import UIKit

final class CharacterListViewVM: NSObject {
    
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

extension CharacterListViewVM: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemRed
        return cell
    }
    
    
}
