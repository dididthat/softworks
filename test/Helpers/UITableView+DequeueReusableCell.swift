//
//  UITableView+DequeueReusableCell.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(
        of class: T.Type,
        for indexPath: IndexPath
    ) -> T? {
        let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath)
        return cell as? T
      }
}
