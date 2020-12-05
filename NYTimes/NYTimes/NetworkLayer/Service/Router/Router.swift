//
//  Router.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import Foundation

public class Router<EndPoint: EndPointType>: NetworkRouter {
    private let manager: SessionManager
    
    public init(manager: SessionManager = DefaultSessionManager()) {
        self.manager = manager
    }
    
    public func request<T: Codable>(_ route: EndPoint, completion: @escaping (Result<T?, Error>) -> Void) {
        do {
            let request = try buildRequest(from: route)
            manager.request(request, completion: { result in
                DispatchQueue.main.async {
                    switch result {
                    case.success(let data, _):
                        do {
                            let decoded: T? = try self.decode(result: data)
                            completion(.success(decoded))
                        }
                        catch {
                            print(error)
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            })
        }
        catch {
            completion(.failure(error))
        }
    }
    
    public func cancel(_ route: EndPoint) {
        guard let request = try? buildRequest(from: route) else { return }
        manager.cancel(request)
    }
    
    public func cancelAllRequest(){
        manager.cancelAllRequest()
    }
    
    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 60)
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters, let urlParameters):
                try configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionalHeaders):
                addAdditionalHeaders(additionalHeaders, request: &request)
                try configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
            
            return request
        }
        catch {
            throw error
        }
    }
    
    private func configureParameters(bodyParameters: EndPoint.BodyParameters? = nil,
                                     urlParameters: EndPoint.URLParameters? = nil,
                                     request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, parameters: bodyParameters)
            }
            
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, parameters: urlParameters)
            }
        }
        catch {
            throw error
        }
    }
    
    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    private func decode<T: Codable>(result: Data?) throws -> T? {
        guard let data = result else {
            return nil
        }
        return try JSONDecoder().decode(T?.self, from: data)
    }
}
