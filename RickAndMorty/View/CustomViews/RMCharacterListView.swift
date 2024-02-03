//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 2.02.2024.
//

import UIKit

/// View that handles showing list of characters, loader, etc
class RMCharacterListView: UIView {
    
    private let viewModel = RMCharacterListViewVM()
    private let loadingSpinner = RMLoadingSpinnerView()
    private var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureLoadingSpinner()
        configureCollectionView()
        getCharactersData()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureLoadingSpinner() {
        addSubview(loadingSpinner)
        loadingSpinner.pinToEdges(of: self)
    }
    
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: self))
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.identifier)
        addSubview(self.collectionView)
        
        collectionView.isHidden = true
        collectionView.alpha = 0
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource   = viewModel
        collectionView.delegate     = viewModel
        
        self.collectionView.pinToEdges(of: self)
    }
    
    
    private func getCharactersData() {
        loadingSpinner.startLoadingAnimation()
        viewModel.fetchCharacters()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.loadingSpinner.stopLoadingAnimation()
            self.collectionView.isHidden = false
            
            UIView.animate(withDuration: 0.5) {
                self.collectionView.alpha = 1
            }
        })
    }
}