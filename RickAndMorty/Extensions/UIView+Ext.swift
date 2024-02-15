//
//  UIView+Ext.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 2.02.2024.
//

import UIKit

extension UIView {
    
    /// Adds the specified views as subviews to the current view.
    ///
    /// - Parameter views: A variable number of UIView instances to be added as subviews.
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
    
    
    /// Pins the current view to the edges of the specified superview.
    /// - Parameter superview: The superview to which the current view will be pinned.
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    
    /// Pins the current view to the edges of the specified superview, taking into account the safe area layout guide.
    /// - Parameter superview: The superview to which the current view will be pinned.
    func pinToEdgesWithSafeAreaLayoutGuide(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
