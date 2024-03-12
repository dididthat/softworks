//
//  DevicesDTO.swift
//
//  Created by Diana 
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
