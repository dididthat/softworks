//
//  MainPresenter.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import Foundation

protocol MainFlowOutput: AnyObject {
    var viewModels: [DeviceViewModel] { get }
    
    func viewDidLoad()
}

final class MainPresenter: MainFlowOutput {
    
    weak var input: MainFlowInput?
    private(set) var viewModels: [DeviceViewModel] = []
    
    private let networkClient: NetworkClient
    
    private var models: [DeviceModel] = []
    
    init(
        networkClient: NetworkClient
    ) {
        self.networkClient = networkClient
    }
    
    func viewDidLoad() {
        loadModels()
    }
}

// MARK: - Private
extension MainPresenter {
    private func loadModels() {
        networkClient.fetch(.devices) { [weak self] (result: Result<DevicesDTO, Error>) in
            guard let self else { return }
                
            switch result {
            case .success(let dto):
                let converter = DeviceDTOToDomainConverter()
                let toViewModelConverter = DeviceModelToViewModelConverter()
                self.models = dto.data.map { converter.convert(from: $0) }
                self.viewModels = self.models.map { toViewModelConverter.convert(from: $0) }
                
                DispatchQueue.main.async {
                    self.input?.reloadData()
                }
                
            case .failure:
                DispatchQueue.main.async {
                    self.input?.showError()
                }
            }
        }
    }
}

private extension NetworkAPI {
    static let devices = NetworkAPI(path: "api/v1/test/devices", method: .get)
}
