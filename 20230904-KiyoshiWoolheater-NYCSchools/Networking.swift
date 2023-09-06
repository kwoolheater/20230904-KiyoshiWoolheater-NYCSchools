//
//  Networking.swift
//  20230904-KiyoshiWoolheater-NYCSchools
//
//  Created by Woolheater, Kiyoshi on 9/4/23.
//

import Foundation

struct Networking {
    func getData<T: Decodable>(urlString: String, completion: @escaping (Result<T, NetworkingError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlString))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.apiError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.responseError))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let object = try decoder.decode(T.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(.apiError))
                }
            }
        }.resume()
    }
}

enum NetworkingError: Error {
    case urlString, apiError, responseError, decodingError
}
