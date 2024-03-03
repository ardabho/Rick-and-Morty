//
//  RMEpisodeDetailView.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 17.02.2024.
//

import UIKit

final class RMEpisodeDetailView: UIView {

    private var viewModel: RMEpisodeDetailVM? {
        didSet {
            loadingSpinner.stopLoadingAnimation()
            self.collectionView?.reloadData()
            self.collectionView?.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.collectionView?.alpha = 1
                
            }
        }
    }
    private var collectionView: UICollectionView?
    private let loadingSpinner = RMLoadingSpinnerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        self.collectionView = createCollectionView()
        
        loadingSpinner.startLoadingAnimation()
        
        guard let collectionView else { return }
        addSubviews(collectionView, loadingSpinner)
        
        loadingSpinner.pinToEdges(of: self)
        collectionView.pinToEdges(of: self)
        
    }
    
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { index, _ in
            return self.layout(for: index)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RMEpisodeInfoCollectionCell.self, forCellWithReuseIdentifier: RMEpisodeInfoCollectionCell.identifier)
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.identifier)
        
        return collectionView
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with viewModel: RMEpisodeDetailVM) {
        self.viewModel = viewModel
    }
    
}

extension RMEpisodeDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = viewModel?.cellViewModels else { return 0 }
        
        let sectionType = sections[section]
        switch sectionType {
        case .information(let viewModels):
            return viewModels.count
        case .characters(let viewModels):
            return viewModels.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        guard let sections = viewModel?.cellViewModels else { fatalError("No View Model") }
        
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .information(let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeInfoCollectionCell.identifier, for: indexPath) as? RMEpisodeInfoCollectionCell else {
                fatalError()
            }
            cell.configure(with: cellViewModel)
            return cell
            
        case .characters(let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.identifier, for: indexPath) as? RMCharacterCollectionViewCell else {
                fatalError()
            }
            cell.setUpCell(with: cellViewModel)
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}


extension RMEpisodeDetailView {
    private func layout(for index: Int) -> NSCollectionLayoutSection {
        guard let sections = viewModel?.cellViewModels else { return createInfoLayout() }
        
        switch sections[index] {
        case .information:
            return createInfoLayout()
        case .characters:
            return createCharacterLayout()
        }
    }
    
    
    private func createInfoLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    
    private func createCharacterLayout() -> NSCollectionLayoutSection {
        let groupWidth = bounds.width
        let groupHeight = (groupWidth / 2) + 70
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(groupWidth), heightDimension: .absolute(groupHeight)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
}
