//
//  RMSettingsOption.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 3.03.2024.
//

import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms Of Service"
        case .privacy:
            return "Privacy"
        case .apiReference:
            return "API Reference"
        case .viewSeries:
            return "View Series"
        case .viewCode:
            return "View Code"
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .privacy:
            return UIImage(systemName: "lock")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .viewSeries:
            return UIImage(systemName: "tv")
        case .viewCode:
            return UIImage(systemName: "hammer")
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemBlue
        case .contactUs:
            return .systemOrange
        case .terms:
            return .systemPurple
        case .privacy:
            return .systemYellow
        case .apiReference:
            return .systemPink
        case .viewSeries:
            return .systemIndigo
        case .viewCode:
            return .systemCyan
        }
    }
    
    var targetURL: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://github.com/ardabho")
        case .terms:
            return URL(string: "https://rickandmortyapi.com/about")
        case .privacy:
            return URL(string: "https://en.wikipedia.org/wiki/Privacy")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/documentation")
        case .viewSeries:
            return URL(string: "https://www.youtube.com/@iOSAcademy")
        case .viewCode:
            return URL(string: "https://github.com/ardabho/Rick-and-Morty")
        }
    }
}
