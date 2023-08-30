//
//  MainPresenter.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import Foundation

protocol MainFlowOutput: AnyObject {
    
}

final class MainPresenter: MainFlowOutput {
    
    weak var input: MainFlowInput?
    
    private let networkClient: NetworkClient
    
    init(
        networkClient: NetworkClient
    ) {
        self.networkClient = networkClient
    }
}
