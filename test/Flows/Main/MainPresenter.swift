//
//  MainPresenter.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import Foundation

protocol MainFlowOutput: AnyObject {
    var loadingState: MainFlowLoadingState { get }
    
    func viewDidLoad()
    func reloadData()
    func removeItem(at index: Int)
}

enum MainFlowLoadingState {
    case loading(skeletonsCount: Int)
    case loaded([DeviceViewModel])
}

final class MainPresenter: MainFlowOutput {
    private static let skeletonsCount = 4
    
    weak var input: MainFlowInput?
    private(set) var loadingState: MainFlowLoadingState
    
    private let toViewModelConverter: DeviceModelToViewModelConverter
    private let networkClient: NetworkClient
    
    private var models: [DeviceModel] = []
    
    init(
        networkClient: NetworkClient
    ) {
        self.networkClient = networkClient
        self.toViewModelConverter = DeviceModelToViewModelConverter()
        self.loadingState = .loading(skeletonsCount: Self.skeletonsCount)
    }
    
    func viewDidLoad() {
        loadModels()
    }
    
    func reloadData() {
        loadingState = .loading(skeletonsCount: Self.skeletonsCount)
        DispatchQueue.main.async {
            self.input?.reloadData()
        }
        loadModels()
    }
    
    func removeItem(at index: Int) {
        models.remove(at: index)
        loadingState = .loaded(models.map { toViewModelConverter.convert(from: $0) })
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
                self.loadingState = .loaded(self.models.map { self.toViewModelConverter.convert(from: $0) })
                
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
