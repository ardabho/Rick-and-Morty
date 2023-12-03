//
//  CollectionViewFooterButtons.swift
//  test
//
//  Created by Arda Büyükhatipoğlu on 2.12.2023.
//

import UIKit

protocol CollectionViewFooterButtonsDelegate: AnyObject {
    func previousTapped(_ footer: CollectionViewFooterButtons)
    func nextTapped(_ footer: CollectionViewFooterButtons)
}

class CollectionViewFooterButtons: UICollectionReusableView {
        
    static let identifier = "CollectionViewFooterButtons"
    weak var delegate: CollectionViewFooterButtonsDelegate?
    
    
    lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        return stack
    }()
    
    lazy var nextButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = Colors.darkBlue
        config.cornerStyle = .capsule
        config.title = "Next"
        config.titleAlignment = .center
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var previousButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = Colors.darkBlue
        config.cornerStyle = .capsule
        config.title = "Previous"
        config.titleAlignment = .center
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(previousButton)
        horizontalStack.addArrangedSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        previousButton.addTarget(self, action: #selector(previousTapped), for: .primaryActionTriggered)
         
        layout()
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: topAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
    
    @objc private func nextTapped(_ sender: UIButton) {
        delegate?.nextTapped(self)
    }
    
    @objc private func previousTapped(_ sender: UIButton) {
        delegate?.previousTapped(self)
    }
    
    func config(hidden: (next: Bool, previous: Bool)) {
        nextButton.isHidden = hidden.next
        previousButton.isHidden = hidden.previous
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
