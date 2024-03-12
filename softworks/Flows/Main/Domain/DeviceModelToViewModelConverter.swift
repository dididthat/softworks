//
//  DeviceModelToViewModelConverter.swift
//
//  Created by Diana 
//

import Foundation

struct DeviceModelToViewModelConverter {
    func convert(from value: DeviceModel) -> DeviceViewModel {
        return DeviceViewModel(
            title: value.name,
            subtitle: value.status,
            isOn: value.isOnline,
            status: value.isOnline ? "ON LINE" : "OFF LINE",
            date: value.lastWorkTime.formatted(date: .omitted, time: .shortened)
        )
    }
}
