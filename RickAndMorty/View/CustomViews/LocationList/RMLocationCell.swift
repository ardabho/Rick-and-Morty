//
//  RMLocationCell.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 5.03.2024.
//

import UIKit

class RMLocationCell: UITableViewCell {

    static let identifier = "RMLocationCell"
    
    private let nameLabel = RMLabel(fontsize: 20, fontWeight: .medium, textAlignment: .natural)
    private let dimensionLabel = RMLabel(fontsize: 15, fontWeight: .regular, textAlignment: .natural, textColor: .secondaryLabel)
    private let typeLabel = RMLabel(fontsize: 15, fontWeight: .light, textAlignment: .natural, textColor: .secondaryLabel)
    
    private var VStack: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureStackView()
        accessoryType = .disclosureIndicator
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        dimensionLabel.text = nil
        typeLabel.text = nil
    }
    
    
    private func configureStackView() {
        VStack = UIStackView()
        VStack.axis = .vertical
        VStack.distribution = .fillProportionally
        VStack.spacing = 2
        
        VStack.addArrangedSubview(nameLabel)
        VStack.addArrangedSubview(dimensionLabel)
        VStack.addArrangedSubview(typeLabel)
        
        addSubview(VStack)
        VStack.pinToEdges(of: self, withPadding: 10)
    }
    
    
    func configure(with viewModel: RMLocationCellVM) {
        nameLabel.text = viewModel.name
        dimensionLabel.text = viewModel.dimension
        typeLabel.text = viewModel.type
    }
}
