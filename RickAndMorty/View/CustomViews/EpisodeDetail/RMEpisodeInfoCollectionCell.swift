//
//  RMEpisodeInfoCollectionCell.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 2.03.2024.
//

import UIKit

final class RMEpisodeInfoCollectionCell: UICollectionViewCell {
    static let identifier = "RMEpisodeInfoCollectionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        setUpLayer()
    }
    
    
    private func setUpLayer() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    func configure(with viewModel: RMEpisodeInfoCollectionCellVM) {
        
    }
}
