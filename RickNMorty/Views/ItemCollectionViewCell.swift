//
//  ItemCollectionViewCell.swift
//  test
//
//  Created by Arda Büyükhatipoğlu on 30.11.2023.
//

import UIKit
import SDWebImage

class ItemCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ItemCollectionViewCell"
    
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 2
        stack.distribution = .fill
        stack.backgroundColor = .gray
        
        return stack
    }()
    
    private let imageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.numberOfLines = 2
        label.backgroundColor = .systemGray2
        label.textColor = Colors.lightBlue
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(verticalStack)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        verticalStack.addArrangedSubview(imageview)
        verticalStack.addArrangedSubview(nameLabel)
        
        layout()
        startShimmer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configure(with model: CollectionViewCellViewModel) {
        stopShimmer()
        imageview.sd_setImage(with: URL(string: model.image))
        nameLabel.text = model.name
        verticalStack.backgroundColor = Colors.crimson
        nameLabel.backgroundColor = .clear
        imageview.backgroundColor = .clear
        
    }
    
    //Skeleton loader animations:
    private func startShimmer() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.nameLabel.backgroundColor = .clear
            self.imageview.backgroundColor = .clear
        })
    }
    
    private func stopShimmer() {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.nameLabel.backgroundColor = .clear
            self.imageview.backgroundColor = .clear
        }, completion: { _ in
            
            self.nameLabel.layer.removeAllAnimations()
            self.imageview.layer.removeAllAnimations()
        })
    }
}
