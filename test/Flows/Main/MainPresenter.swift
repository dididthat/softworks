//
//  MainPresenter.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import Foundation

protocol MainFlowOutput: AnyObject {
    func viewDidLoad()
}

final class MainPresenter: MainFlowOutput {
    
    weak var input: MainFlowInput?
    
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
                self.models = dto.data.map { converter.convert(from: $0) }
                self.input?.reloadData()
                
            case .failure:
                self.input?.showError()
            }
        }
    }
}

private extension NetworkAPI {
    static let devices = NetworkAPI(path: "api/v1/test/devices", method: .get)
}
