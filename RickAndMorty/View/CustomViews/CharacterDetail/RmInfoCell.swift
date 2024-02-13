//
//  RmCharacterDetailCollectionViewCell.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 12.02.2024.
//

import UIKit

final class RmCharacterDetailInfoViewCell: UICollectionViewCell {
    static let identifier = "RmCharacterDetailInfoViewCell"
    
    private let titleLabel = RMLabel(fontsize: 16, fontWeight: .semibold, textAlignment: .center)
    private let valueLabel = RMLabel(fontsize: 15, fontWeight: .medium, textAlignment: .center)
    private let titleContainer = UIView()
    private let valueContainer = UIView()
    private var iconImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        
        configureTitleContainer()
        configureIconImageView()
        configureTitleLabel()
        
        configureValueContainer()
        configureValueLabel()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    private func configureCell() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    
    private func configureTitleContainer() {
        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        titleContainer.backgroundColor = .tertiarySystemBackground
        contentView.addSubview(titleContainer)
        
        
        NSLayoutConstraint.activate([
            titleContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleContainer.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
        ])
    }
    
    
    private func configureIconImageView() {
        iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: "globe.europe.africa.fill")
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleContainer.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor, constant: 10),
            iconImageView.topAnchor.constraint(equalTo: titleContainer.topAnchor, constant: 10),
            iconImageView.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: -10),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
            
        ])
    }
    
    
    private func configureTitleLabel() {
        titleContainer.addSubview(titleLabel)
        titleLabel.text = "Total\nEpisodes"
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: titleContainer.centerXAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor, constant: -5),
            titleLabel.topAnchor.constraint(equalTo: titleContainer.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor),
            
        ])
    }
    
    
    private func configureValueContainer() {
        valueContainer.translatesAutoresizingMaskIntoConstraints = false
        valueContainer.backgroundColor = .secondarySystemBackground
        contentView.addSubview(valueContainer)
        
        NSLayoutConstraint.activate([
            valueContainer.topAnchor.constraint(equalTo: titleContainer.bottomAnchor),
            valueContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            valueContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            valueContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    
    private func configureValueLabel() {
        valueLabel.text = "value"
        valueLabel.numberOfLines = 0
        valueLabel.adjustsFontSizeToFitWidth = false
        valueContainer.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: valueContainer.centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: valueContainer.centerYAnchor),
            valueLabel.widthAnchor.constraint(lessThanOrEqualTo: valueContainer.widthAnchor, multiplier: 0.9),
            valueLabel.heightAnchor.constraint(lessThanOrEqualTo: valueContainer.heightAnchor, multiplier: 0.9)
        ])
    }
}
