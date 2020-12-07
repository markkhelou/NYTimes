//
//  File.swift
//  NYTimes
//
//  Created by marc helou on 12/5/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import Foundation


class NetworkService {
    
    class func request<T: Codable>(router: Router, completion: @escaping (Result<T?, Error>) -> Void) {
        
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        let session = URLSession(configuration: .default)
        guard let url = components.url else {
            completion(.failure(NetworkRequestError.missingURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method.rawValue
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                
                if let error =  error {
                    completion(.failure(error))
                    return
                }
                guard response != nil else {
                    completion(.failure(NetworkResponseError.noResponse))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkResponseError.noData))
                    return
                }
                
                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(responseObject))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
