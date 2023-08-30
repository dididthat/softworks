//
//  MainViewController.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import UIKit
import SnapKit

protocol MainFlowInput: AnyObject {
    func reloadData()
    func showError()
}

final class MainViewController: UIViewController {
    
    private let output: MainFlowOutput
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        
        tableView.register(DeviceTableViewCell.self, forCellReuseIdentifier: DeviceTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
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
        
        setupUI()
        
        output.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.snp.leading).inset(30)
            $0.trailing.equalTo(view.snp.trailing).inset(30)
            $0.bottom.equalTo(view.snp.bottom)
        }
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(of: DeviceTableViewCell.self, for: indexPath),
           let model = output.viewModels[safe: indexPath.row] {
            cell.configure(with: model)
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
}

// MARK: - MainFlowInput
extension MainViewController: MainFlowInput {
    func reloadData() {
        tableView.reloadData()
    }
    
    func showError() {
        
    }
}
