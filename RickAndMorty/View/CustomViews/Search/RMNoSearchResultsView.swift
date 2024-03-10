//
//  RMNoSearchResultsView.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 10.03.2024.
//

import UIKit

class RMNoSearchResultsView: UIView {
    
    //MARK: - ViewModel
    private let viewModel = RMNoSearchResultsViewVM()
    
    //MARK: - Components
    private let iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .label
        iconView.translatesAutoresizingMaskIntoConstraints = false
        return iconView
    }()
    
    private let label = RMLabel(fontsize: 20, fontWeight: .medium, textAlignment: .center)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(iconView, label)
        addConstraints()
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Functions
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
                // IconView Constraints
                iconView.widthAnchor.constraint(equalToConstant: 90),
                iconView.heightAnchor.constraint(equalToConstant: 90),
                iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
                iconView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
                
                // Label Constraints
                label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 20),
                label.leadingAnchor.constraint(equalTo: leadingAnchor),
                label.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
    }
    
    
    private func configure() {
        isHidden = true
        label.text = viewModel.title
        iconView.image = viewModel.image
    }

}
