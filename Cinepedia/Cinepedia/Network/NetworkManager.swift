//
//  NetworkManager.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 24.04.2022.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared: NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()
    
    
    let reachabilityManager = NetworkReachabilityManager()?.isReachable
    
    func isConnectedToInternet() -> Bool {
        return reachabilityManager ?? false
    }
    
    func request<T: Codable>(_ request: URLRequestConvertible,
                             decodeToType type: T.Type,
                             completionHandler: @escaping (Result<T,Error>) -> ()) {
        AF.request(request).responseData { response in
            
            switch response.result {
                
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(type.self, from: data)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
