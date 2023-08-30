//
//  DevicesDTO.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import Foundation

struct DevicesDTO: Decodable {
    let data: [DeviceDTO]
}

struct DeviceDTO: Decodable {
    let id: Int
    let name: String
    let icon: String
    let isOnline: Bool
    let status: String
    let lastWorkTime: Date
}
