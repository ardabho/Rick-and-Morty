//
//  LoadingSpinner.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 2.02.2024.
//

import UIKit

class RMLoadingSpinnerView: UIView {

    private let spinner = UIActivityIndicatorView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureActivityIndicator()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureActivityIndicator() {
        addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.style = .large
        spinner.hidesWhenStopped = true
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    
    func startLoadingAnimation() {
        spinner.startAnimating()
    }
    
    
    func stopLoadingAnimation() {
        spinner.stopAnimating()
    }
}

