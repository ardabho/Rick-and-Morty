//
//  RMCharacterDetailView.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 11.02.2024.
//

import UIKit

class RMCharacterDetailView: UIView {
    
    var collectionView: UICollectionView?
    private let loadingSpinner = RMLoadingSpinnerView()
    private var viewModel : RMCharacterDetailVM
    
    init(frame: CGRect, viewModel: RMCharacterDetailVM) {
        self.viewModel = viewModel
        super.init(frame: frame)        
        configureView()
        configureLoadingSpinner()
        createCollectionView()
    }
    
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureLoadingSpinner() {
        addSubview(loadingSpinner)
        loadingSpinner.pinToEdges(of: self)
        loadingSpinner.startLoadingAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.collectionView = collectionView
        
        guard let strongCollectionView = self.collectionView else {
            
            return
        }
        
        addSubview(strongCollectionView)
        strongCollectionView.pinToEdges(of: self)
        loadingSpinner.stopLoadingAnimation()
    }
    
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionTypes = viewModel.sections
        
        switch sectionTypes[sectionIndex] {
        case .photo:
            return viewModel.createPhotoSectionLayout()
        case .information:
            return viewModel.createInformationSectionLayout()
        case .episodes:
            return viewModel.createEpisodesSectionLayout()
        }
        
    }
}
