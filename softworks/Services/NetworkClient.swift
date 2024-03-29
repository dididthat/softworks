//
//  NetworkClient.swift
//
//  Created by Diana 
//

import Foundation

enum NetworkClientError: Error {
    case emptyResult
}

final class NetworkClient {
    private let basicPathURL = URL(string: "https://api.fasthome.io/")!
    
    func fetch<T: Decodable>(
        _ api: NetworkAPI,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let url = basicPathURL.appendingPathComponent(api.path)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = NetworkMethodToStringConverter().convert(from: api.method)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            if let data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let model = try decoder.decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NetworkClientError.emptyResult))
            }
            
        }.resume()
    }
}

private struct NetworkMethodToStringConverter {
    func convert(from value: NetworkMethod) -> String {
        switch value {
        case .get:
            return "GET"
        }
    }
}
