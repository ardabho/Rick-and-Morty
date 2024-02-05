//
//  RMCharacterListViewVM.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 2.02.2024.
//

import UIKit


protocol RMCharacterListViewVMDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(_ character: RMCharacter)
}

/// View Model to handle character list view logic
final class RMCharacterListViewVM: NSObject {
    
    weak var delegate: RMCharacterListViewVMDelegate?
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellVM(characterName: character.name, characterStatus: character.status, imageURL: URL(string: character.image))
                cellViewModels.append(viewModel)
                DispatchQueue.main.async {
                    self.delegate?.didLoadInitialCharacters()
                }
            }
        }
    }
    
    private var cellViewModels: [RMCharacterCollectionViewCellVM] = [] //Array of View Models to populate collection view
    private var apiInfo: RMInfo? = nil
    
    ///Fetch initial set of characters(20)
    func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequests, expecting: RMCharactersResponse.self) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let charactersResponse):
                self.characters = charactersResponse.results
                self.apiInfo    = charactersResponse.info
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    ///Paginate if  additional characters are needed
    func fetchAdditionalCharacters() {
        
    }
    
    var shouldShowLoadingIndicator: Bool {
        return apiInfo?.next != nil
    }
}

// MARK: - Collection View

extension RMCharacterListViewVM: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.identifier, for: indexPath) as? RMCharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUpCell(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectCharacter(characters[indexPath.row])
    }
}

// MARK: - Scrollview

extension RMCharacterListViewVM: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadingIndicator else {
            return
        }
    }
}
