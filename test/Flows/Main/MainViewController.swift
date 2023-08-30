//
//  MainViewController.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import UIKit

protocol MainFlowInput: AnyObject {
    func reloadData()
    func showError()
}

final class MainViewController: UIViewController {
    
    private let output: MainFlowOutput
    
    init(
        output: MainFlowOutput
    ) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewDidLoad()
    }
}

// MARK: - MainFlowInput
extension MainViewController: MainFlowInput {
    func reloadData() {

    }
    
    func showError() {
        
    }
}
