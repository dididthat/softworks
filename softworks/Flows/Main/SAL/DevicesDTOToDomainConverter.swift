//
//  DevicesDTOToDomainConverter.swift
//
//  Created by Diana 
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
