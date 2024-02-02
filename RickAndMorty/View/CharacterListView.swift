//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 2.02.2024.
//

import UIKit

/// View that handles showing list of characters, loader, etc
class CharacterListView: UIView {
    
    private let viewModel = CharacterListViewVM()
    private let loadingSpinner = LoadingSpinnerView()
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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.isHidden = true
        collectionView.alpha = 0
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource   = viewModel
        collectionView.delegate     = viewModel
        
        addSubview(self.collectionView)
        self.collectionView.pinToEdges(of: self)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.loadingSpinner.stopLoadingAnimation()
            self.collectionView.isHidden = false
            
            UIView.animate(withDuration: 0.5) {
                self.collectionView.alpha = 1
            }
        })
    }
    
    
    private func getCharactersData() {
        loadingSpinner.startLoadingAnimation()
        viewModel.fetchCharacters()
    }
}
