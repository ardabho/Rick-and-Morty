//
//  Colors.swift
//  test
//
//  Created by Arda Büyükhatipoğlu on 1.12.2023.
//

import UIKit

struct Colors {
    static let lightBlue: UIColor = UIColor(hex: "#EEF5FF", alpha: 1)
    static let mediumBlue: UIColor = UIColor(hex: "#9EB8D9", alpha: 1)
    static let darkBlue: UIColor = UIColor(hex: "#7C93C3", alpha: 1)
    static let crimson: UIColor = UIColor(hex: "#A25772", alpha: 1)
    static let blue: UIColor = .systemBlue
    static let purple: UIColor = .systemPurple
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
