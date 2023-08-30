//
//  UIFont+Custom.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import UIKit

extension UIFont {
    static func roboto(size: Int) -> UIFont {
        UIFont(name: "Roboto", size: CGFloat(size)) ?? .boldSystemFont(ofSize: CGFloat(size))
    }
}
