//
//  UIHelper.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 2.02.2024.
//

import UIKit

struct UIHelper {
    
    static let borderColors: [UIColor] = [
        .systemRed,
        .systemOrange,
        .systemYellow,
        .systemTeal,
        .systemPink,
        .systemPurple,
        .systemBlue,
        .systemCyan,
        .systemBrown,
        .systemIndigo,
        .systemGreen,
        .systemGray
    ]
    
    static func createTwoColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = UIScreen.main.bounds.width
        let padding: CGFloat = 10
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing)
        let itemWidth = availableWidth / 2
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.4)
        flowlayout.minimumInteritemSpacing = minimumItemSpacing
        
        return flowlayout
    }
    
    
    static func createSingleColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = UIScreen.main.bounds.width
        let padding: CGFloat = 10
        let availableWidth = width - (padding * 2)
        let itemWidth = availableWidth
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize = CGSize(width: itemWidth, height: 100)
        
        return flowlayout
    }
}
