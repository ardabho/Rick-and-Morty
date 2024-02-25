//
//  RMEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 12.02.2024.
//

import UIKit

final class RMEpisodeCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMEpisodeCollectionViewCell"
    
    private let stackView = UIStackView()
    private let episodeLabel = RMLabel(fontsize: 17, fontWeight: .semibold)
    private let nameLabel = RMLabel(fontsize: 16, fontWeight: .medium)
    private let airDateLabel = RMLabel(fontsize: 15, fontWeight: .regular)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCellView()
        configureStackView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    private func configureCellView() {
        contentView.backgroundColor     = .secondarySystemBackground
        contentView.layer.cornerRadius  = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemOrange.cgColor
        contentView.layer.masksToBounds = true
        
    }
    
    
    private func configureStackView() {
        stackView.spacing = 2
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(episodeLabel)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(airDateLabel)
        
        stackView.pinToEdges(of: contentView, withPadding: 10)
    }
    
    /// Used in character detail screen
    func configure(with viewModel: RMEpisodeCollectionCellVM) {
        viewModel.registerForData { [weak self] episodeData in
            guard let self else { return }
            
            self.episodeLabel.text = episodeData.episode
            self.nameLabel.text = episodeData.name
            self.airDateLabel.text = episodeData.airDate
        }
        viewModel.fetchEpisode()
    }
    
    /// Used in episode list screen
    func configureList(with viewModel: RMEpisodeListCollectionViewCellVM) {
        self.episodeLabel.text = viewModel.episode
        self.nameLabel.text = viewModel.name
        self.airDateLabel.text = viewModel.airDate
        self.contentView.layer.borderColor = viewModel.borderColor.cgColor
    }
    
}
