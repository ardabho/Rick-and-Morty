//
//  RmCharacterDetailInfoCellVM.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 12.02.2024.
//

import UIKit

struct RmCharacterDetailInfoCellVM {
    private let value: String
    let title: String
    let iconImage: UIImage
    let tintColor: UIColor
    let type: Type
    
    var displayValue: String {
        if value.isEmpty { return "N/A" }
        
        if type == .created {
            guard let date = value.formatDateFromISOToString() else {
                return "N/A"
            }
            return date
        }
        
        return value
    }

    
    enum `Type`: String {
        case status         = "Status"
        case gender         = "Gender"
        case type           = "Type"
        case species        = "Species"
        case origin         = "Origin"
        case location       = "Location"
        case created        = "Created"
        case episodeCount   = "Episode\nCount"
    }

    
    init(type: Type, value: String) {
        self.value = value
        self.type = type
        self.title = type.rawValue
        
        switch type {
        case .status:
            let image = UIImage(systemName: "bell")!
            tintColor = .systemBlue
            iconImage = image
        case .gender:
            let image = UIImage(systemName: "bell")!
            tintColor = .systemRed
            iconImage = image
        case .type:
            let image = UIImage(systemName: "bell")!
            tintColor = .systemPurple
            iconImage = image
        case .species:
            let image = UIImage(systemName: "bell")!
            tintColor = .systemGreen
            iconImage = image
        case .origin:
            let image = UIImage(systemName: "bell")!
            tintColor = .systemOrange
            iconImage = image
        case .location:
            let image = UIImage(systemName: "bell")!
            tintColor = .systemPink
            iconImage = image
        case .created:
            let image = UIImage(systemName: "bell")!
            tintColor = .systemYellow
            iconImage = image
        case .episodeCount:
            let image = UIImage(systemName: "bell")!
            tintColor = .systemMint
            iconImage = image
        }
    }
}
