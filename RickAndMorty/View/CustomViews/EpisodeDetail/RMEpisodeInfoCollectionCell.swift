//
//  RMEpisodeInfoCollectionCell.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 2.03.2024.
//

import UIKit

final class RMEpisodeInfoCollectionCell: UICollectionViewCell {
    static let identifier = "RMEpisodeInfoCollectionCell"
    
    private let titleLabel = RMLabel(fontsize: 20, fontWeight: .medium, textAlignment: .left)
    private let valueLabel = RMLabel(fontsize: 18, fontWeight: .regular, textAlignment: .right)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayer()
        setUpSubviews()
    }
    
    
    private func setUpLayer() {
        contentView.backgroundColor = .secondarySystemBackground
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    
    private func setUpSubviews() {
        contentView.addSubviews(titleLabel, valueLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.47),
            valueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.47),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    
    func configure(with viewModel: RMEpisodeInfoCollectionCellVM) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}
