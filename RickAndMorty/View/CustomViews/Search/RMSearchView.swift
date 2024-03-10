//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 10.03.2024.
//

import UIKit

class RMSearchView: UIView {

    private let viewModel: RMSearchViewVM
    
    //MARK: - Subviews
    
    // SeartchInputView(bar, selection  buttons)
    
    //NO Results view
    private let noResultsView = RMNoSearchResultsView()
    
    //Results collectionView
    
    //MARK: - Init
    
    init(frame: CGRect, viewModel: RMSearchViewVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(noResultsView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addConstraints() {
        noResultsView.pinToEdges(of: self)
    }
    
}

//MARK: - CollectionView 

extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected cell is: ", indexPath)
    }
    
}
