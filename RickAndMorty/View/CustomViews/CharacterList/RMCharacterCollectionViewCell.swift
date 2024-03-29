//
//  RMCharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 3.02.2024.
//

import UIKit

class RMCharacterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RMCharacterCollectionViewCell"
    
    private var characterImageView: UIImageView!
    private let nameLabel = RMLabel(fontsize: 18, fontWeight: .semibold, textAlignment: .center)
    private let statusLabel = RMLabel(fontsize: 16, fontWeight: .regular, textAlignment: .left)
    
    private let cornerRadius: CGFloat = 10
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureCharacterImageView()
        configureLabels()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    private func configureCell() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = cornerRadius
        configureShadow()
    }
    
    
    private func configureShadow() {
        layer.shadowColor = UIColor.label.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: -2, height: 2)
        layer.shadowRadius = 4
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        configureShadow()
    }
    
    
    private func configureCharacterImageView() {
        characterImageView = UIImageView()
        addSubview(characterImageView)
        
        characterImageView.contentMode = .scaleAspectFit
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.backgroundColor = .lightGray
        
        characterImageView.layer.cornerRadius = cornerRadius
        characterImageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor)
        ])
    }
    
    
    private func configureLabels() {
        addSubviews(nameLabel, statusLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 3),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -5),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            statusLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),

            statusLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor, multiplier: 0.6),
        ])
    }
    
    /// Sets up the cell with the provided view model, updating the UI elements with character information.
    ///
    /// - Parameters:
    ///   - viewModel: The view model containing character information to be displayed.
    internal func setUpCell(with viewModel: RMCharacterCollectionViewCellVM) {
        self.nameLabel.text = viewModel.characterName
        self.statusLabel.text = "Status: \(viewModel.characterStatusText)"
        
        viewModel.fetchImage { [weak self] result in
            guard let self else { return }
    
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)
                    self.characterImageView.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
}
