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
    func didLoadAdditionalCharacters(with newIndexpaths: [IndexPath])
}

/// View Model to handle character list view logic
final class RMCharacterListViewVM: NSObject {
    
    weak var delegate: RMCharacterListViewVMDelegate?
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellVM(characterName: character.name, characterStatus: character.status, imageURL: URL(string: character.image))
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
                
            }
        }
    }
    
    private var cellViewModels: [RMCharacterCollectionViewCellVM] = [] //Array of View Models to populate collection view
    private var apiInfo: RMInfo? = nil
    private var isLoadingMoreCharacters = false
    
    ///Fetch initial set of characters(20)
    func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequests, expecting: RMCharactersResponse.self) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let charactersResponse):
                self.characters = charactersResponse.results
                self.apiInfo    = charactersResponse.info
                DispatchQueue.main.async {
                    self.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    ///Paginate if  additional characters are needed
    func fetchAdditionalCharacters(from url: URL) {
        isLoadingMoreCharacters = true
        guard let request = RMRequest(url: url) else {
            isLoadingMoreCharacters = false
            print("Failed to create request")
            return
        }
        
        RMService.shared.execute(request, expecting: RMCharactersResponse.self) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let responseModel):
                
                self.apiInfo = responseModel.info
                
                let originalCount = self.characters.count
                let newCount = responseModel.results.count
                let totalCount = originalCount + newCount
                let startingIndex = totalCount - newCount
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex + newCount)).compactMap({return IndexPath(row: $0, section: 0)})
                
                self.characters.append(contentsOf: responseModel.results)

                self.delegate?.didLoadAdditionalCharacters(with: indexPathsToAdd)
                self.isLoadingMoreCharacters = false
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
        
    }
    
    
    var shouldShowLoadingIndicator: Bool {
        return apiInfo?.next != nil
    }
}

// MARK: - Collection View

extension RMCharacterListViewVM: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //Data Source
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
    
    
    //Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            return UICollectionReusableView()
        }
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier, for: indexPath) as! RMFooterLoadingCollectionReusableView
        
        shouldShowLoadingIndicator ? cell.startLoadingAnimation() : cell.stopLoadingAnimation()
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadingIndicator else {
            return .zero
        }
        
        return CGSize(width: collectionView.bounds.width, height: 65)
    }
    
    
    //Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectCharacter(characters[indexPath.row])
    }
}

// MARK: - Scrollview

extension RMCharacterListViewVM: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadingIndicator, !isLoadingMoreCharacters, !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
                let url = URL(string: nextUrlString) else {
            return
        }
        let offsetY = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let scrollviewFrameHeight = scrollView.frame.height
        
        if (offsetY >= totalContentHeight - scrollviewFrameHeight - 85) {
            fetchAdditionalCharacters(from: url)
        }
    }
}
