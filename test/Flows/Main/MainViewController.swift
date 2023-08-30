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
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .clear
        
        tableView.register(DeviceTableViewCell.self, forCellReuseIdentifier: DeviceTableViewCell.identifier)
        tableView.register(LoadingDeviceTableViewCell.self, forCellReuseIdentifier: LoadingDeviceTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private let reloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("ОБНОВИТЬ", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        button.configuration = .plain()
        button.configuration?.contentInsets = .init(top: 15, leading: 24, bottom: 15, trailing: 24)
        return button
    }()
    
    private let loaderView = LoaderView()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Что то пошло не так, \nошибка 123"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("ПОВТОРИТЬ", for: .normal)
        button.backgroundColor = .under
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.configuration = .plain()
        button.configuration?.contentInsets = .init(top: 12, leading: 22, bottom: 12, trailing: 22)
        return button
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
        bindButtons()
        
        reloadData()
        output.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        
        view.addSubview(tableView)
        view.addSubview(reloadButton)
        view.addSubview(loaderView)
        view.addSubview(errorLabel)
        view.addSubview(retryButton)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.snp.leading).inset(30)
            $0.trailing.equalTo(view.snp.trailing).inset(30)
            $0.bottom.equalTo(view.snp.bottom)
        }
        
        reloadButton.snp.makeConstraints {
            $0.trailing.equalTo(view.snp.trailing).inset(17)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(26)
        }
        
        loaderView.snp.makeConstraints {
            $0.trailing.equalTo(view.snp.trailing).inset(17)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(26)
        }
        
        errorLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY).multipliedBy(0.90)
        }
        
        retryButton.snp.makeConstraints {
            $0.top.equalTo(errorLabel.snp.bottom).offset(55)
            $0.centerX.equalTo(view.snp.centerX)
        }
    }
    
    private func bindButtons() {
        reloadButton.addTarget(self, action: #selector(reloadButtonDidTap), for: .touchUpInside)
        retryButton.addTarget(self, action: #selector(reloadButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    private func reloadButtonDidTap() {
        output.reloadData()
    }
    
    private func showDialogForDeleting(productName: String, indexPath: IndexPath) {
        let alert = UIAlertController(title: "Вы хотите удалить", message: "\(productName)?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .default))
        
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { [weak self] action in
            guard let self else { return }
            
            self.output.removeItem(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }))
        
        present(alert, animated: true)
    }
    
    private func changeErrorState(_ flag: Bool) {
        tableView.isHidden = flag
        loaderView.isHidden = flag
        reloadButton.isHidden = flag
        errorLabel.isHidden = !flag
        retryButton.isHidden = !flag
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch output.loadingState {
        case .loaded(let models):
            return models.count
            
        case .loading(let skeletonsCount):
            return skeletonsCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch output.loadingState {
        case .loading:
            if let cell = tableView.dequeueReusableCell(of: LoadingDeviceTableViewCell.self, for: indexPath) {
                return cell
            }
            
        case .loaded(let models):
            if let cell = tableView.dequeueReusableCell(of: DeviceTableViewCell.self, for: indexPath),
               let model = models[safe: indexPath.row] {
                cell.configure(with: model)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch output.loadingState {
        case .loading:
            return false
            
        case .loaded:
            return true
        }
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard
            editingStyle == .delete,
            case .loaded(let models) = output.loadingState,
            let titleModel = models[safe: indexPath.row]?.title
        else { return }
        
        showDialogForDeleting(productName: titleModel, indexPath: indexPath)
    }
}

// MARK: - MainFlowInput
extension MainViewController: MainFlowInput {
    func reloadData() {
        guard isViewLoaded else { return }
        
        changeErrorState(false)
        
        tableView.reloadData()
        switch output.loadingState {
        case .loaded:
            UIView.animate(withDuration: 0.3) {
                self.reloadButton.alpha = 1
                self.loaderView.alpha = 0
                self.loaderView.stopLoading()
            }
            
        case .loading:
            reloadButton.alpha = 0
            loaderView.alpha = 1
            loaderView.startLoading()
        }
    }
    
    func showError() {
        changeErrorState(true)
    }
}
