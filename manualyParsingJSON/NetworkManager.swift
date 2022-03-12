//
//  NetworkManager.swift
//  manualyParsingJSON
//
//  Created by User on 11.03.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    enum NetworkError: Error {
        case InvalidURL
        case NoData
        case DecoderError
    }
    
    func fetchData(url: String, completion: @escaping (Result<[User],NetworkError>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.InvalidURL))
            print(NetworkError.InvalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.NoData))
                print(NetworkError.NoData)
                return
            }
            
            do {
                guard let json = try? JSONSerialization.jsonObject(with: data) else {return}
                let users = User.getUser(value: json)
                
                DispatchQueue.main.async {
                    DispatchQueue.main.async {
                        completion(.success(users))
                    }
                }
            } catch {
                completion(.failure(.DecoderError))
            }
            
        }.resume()
    }
    
    private init() {}
}
