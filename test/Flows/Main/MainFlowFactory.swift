//
//  MainFlowFactory.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import UIKit

struct MainFlowFactory {
    func mainFlow() -> UIViewController {
        let presenter = MainPresenter(networkClient: NetworkClient())
        let viewController = MainViewController(output: presenter)
        presenter.input = viewController
        return viewController
    }
}
