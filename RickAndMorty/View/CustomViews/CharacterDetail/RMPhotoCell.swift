//
//  RMCharacterPhotoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 12.02.2024.
//

import UIKit

final class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMCharacterPhotoCollectionViewCell"
    
    private var avatarImageView: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImageView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureImageView() {
        avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.layer.cornerRadius = 10
        avatarImageView.clipsToBounds = true
        contentView.addSubview(avatarImageView)
        avatarImageView.pinToEdges(of: contentView)
    }
    
    
    func configure(with viewModel: RMCharacterPhotoCellVM) {
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.avatarImageView.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}
