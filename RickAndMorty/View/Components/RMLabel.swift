//
//  RMLabel.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 3.02.2024.
//

import UIKit

class RMLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Usupported")
    }
    
    
    convenience init(fontsize: CGFloat = 17, fontWeight: UIFont.Weight = .regular, textAlignment: NSTextAlignment = .natural ) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontsize, weight: fontWeight)
        self.textAlignment = textAlignment
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        lineBreakMode                             = .byTruncatingTail
        adjustsFontSizeToFitWidth                 = true
        minimumScaleFactor                        = 0.8
        numberOfLines                             = 2
    }

}
