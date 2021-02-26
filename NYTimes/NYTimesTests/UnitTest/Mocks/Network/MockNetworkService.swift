//
//  MockNetworkService.swift
//  NYTimesTests
//
//  Created by marc helou on 2/26/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

@testable import NYTimes
import Combine

class MockNetworkService: NetworkServiceProtocol {
    var url: String?
    var method: HTTPMethod = .get
    var body: Codable?
    var queries: [String: String] = [:]
    var headers: [String: String] = [:]
    
    var response: Result<Codable, NetworkError>
    init(_ response: Result<Codable, NetworkError>) {
        self.response = response
    }
    
    func withMethod(_ method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    func withURL(_ url: String) -> Self {
        self.url = url
        return self
    }
    
    func withBody<Request: Codable>(_ body: Request) -> Self {
        self.body = body
        return self
    }
    
    func withQueries(_ queries: [String : String]) -> Self {
        self.queries = queries
        return self
    }
    
    func withHeaders(_ headers: [String : String]) -> Self {
        self.headers = headers
        return self
    }
    
    func request<Response: Codable>() -> Future<Response, NetworkError> {
        Future { promise in
            if self.url == nil {
                promise(.failure(NetworkError.wrongURLFormat))
            }
            switch self.response {
            case .success(let response): promise(.success(response as! Response))
            case .failure(let error): promise(.failure(error))
            }
        }
    }
}
