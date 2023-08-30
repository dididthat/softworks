//
//  UIColor+Hex.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import UIKit

extension UIColor {
    convenience init?(hex: String) {
        var hex: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        guard
            hex.hasPrefix("#"),
            hex.count == 7
        else {
            self.init()
            return
        }
        
        hex.remove(at: hex.startIndex)
        
        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}
