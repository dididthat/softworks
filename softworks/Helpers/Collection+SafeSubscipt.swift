//
//  Collection+SafeSubscipt.swift
//
//  Created by Diana 
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
