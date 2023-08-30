//
//  DevicesDTOToDomainConverter.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import Foundation

struct DeviceDTOToDomainConverter {
    func convert(from value: DeviceDTO) -> DeviceModel {
        return DeviceModel(
            id: value.id,
            name: value.name,
            icon: value.icon,
            isOnline: value.isOnline,
            status: value.status,
            lastWorkTime: value.lastWorkTime
        )
    }
}
