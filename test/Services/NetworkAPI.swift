//
//  NetworkAPI.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import Foundation

struct NetworkAPI {
    let path: String
    let method: NetworkMethod
}

enum NetworkMethod {
    case get
}
