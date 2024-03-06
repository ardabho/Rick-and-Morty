//
//  RMCharacterDetailVM.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 5.02.2024.
//

import UIKit

final class RMCharacterDetailVM {
    
    private let character: RMCharacter
    private let spacing: CGFloat = 5 //Collection view group  spacing
    enum SectionType {
        case photo(viewModel: RMCharacterPhotoCellVM)
        case information(viewModels: [RmCharacterDetailInfoCellVM])
        case episodes(viewModels: [RMEpisodeCollectionCellVM])
    }
    var sections: [SectionType] = []
    var episodes: [String] {
        return character.episode
    }
    // MARK: - Init
    
    init(character: RMCharacter) {
        self.character = character
        setUpSections()
    }
    
    
    private func setUpSections() {
        sections = [
            .photo(viewModel: RMCharacterPhotoCellVM(imageUrl: URL(string: character.image))),
            .information(viewModels: [
                RmCharacterDetailInfoCellVM(type: .status, value: character.status.text),
                RmCharacterDetailInfoCellVM(type: .gender, value: character.gender.text) ,
                RmCharacterDetailInfoCellVM(type: .type, value: character.type ),
                RmCharacterDetailInfoCellVM(type: .species, value: character.species ),
                RmCharacterDetailInfoCellVM(type: .origin, value: character.origin.name ),
                RmCharacterDetailInfoCellVM(type: .location, value: character.location.name ),
                RmCharacterDetailInfoCellVM(type: .created, value: character.created ),
                RmCharacterDetailInfoCellVM(type: .episodeCount, value: String(character.episode.count)),
            ]),
            .episodes(viewModels: character.episode.compactMap ({
                return RMEpisodeCollectionCellVM(episodeDataUrl: URL(string: $0))
            }))
        ]
    }
    
    
    var nameText: String {
        return character.name.uppercased()
    }
    
    // MARK: - Layouts
    
    internal func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        return section
    }
    
    
    internal func createInformationSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    
    internal func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(100)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
}
