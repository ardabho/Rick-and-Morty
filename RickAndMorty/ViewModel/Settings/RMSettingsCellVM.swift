//
//  RMSettingsCellViewVM.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 3.03.2024.
//

import UIKit

struct RMSettingsCellVM: Identifiable {
    let id = UUID()
    
    let type: RMSettingsOption
    let onTapHandler: (RMSettingsOption) -> Void
    
    // MARK: - Init
    
    init(type: RMSettingsOption, onTapHandler: @escaping (RMSettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
    // MARK: - Public
    
    var image: UIImage? {
        return type.iconImage
    }
    
    var title: String {
        return type.displayTitle
    }
    
    var backgroundColor: UIColor {
        return type.iconContainerColor
    }
}
