//
//  UIFont+Custom.swift
//
//  Created by Diana 
//

import UIKit

extension UIFont {
    static func roboto(size: Int) -> UIFont {
        UIFont(name: "Roboto", size: CGFloat(size)) ?? .boldSystemFont(ofSize: CGFloat(size))
    }
}
