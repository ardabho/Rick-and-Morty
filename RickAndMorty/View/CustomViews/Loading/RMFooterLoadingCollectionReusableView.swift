//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 6.02.2024.
//

import UIKit

class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "RMFooterLoadingCollectionReusableView"
    
    private let loadingView = RMLoadingSpinnerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    private func configure() {
        backgroundColor = .systemBackground
        addSubview(loadingView)
        loadingView.pinToEdges(of: self)
    }
    
    
    func startLoadingAnimation() {
        loadingView.startLoadingAnimation()
    }
    
    
    func stopLoadingAnimation() {
        loadingView.stopLoadingAnimation()
    }
    
}
