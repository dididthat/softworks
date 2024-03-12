//
//  MainFlowFactory.swift
//
//  Created by Diana 
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
