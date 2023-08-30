//
//  Collection+SafeSubscipt.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
