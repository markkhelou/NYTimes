//
//  ArticleRepository.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import Foundation

enum ArticleEndpointType: EndPointType {
    typealias BodyParameters = [String: String]
    typealias URLParameters = [String: String]
    
    case articles(predicate: URLParameters)
    
    var baseURL: URL {
        switch self {
        case .articles: return URL(string: "http://api.nytimes.com/svc/mostpopular/v2/viewed")!
        }
    }
    
    var path: String {
        switch self {
        case .articles: return "1.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .articles: return .get
        }
    }
    
    var task: HTTPTask<BodyParameters, URLParameters> {
        switch self {
        case .articles(let predicate):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: predicate)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

class ArticleRepository {
    static let shared = ArticleRepository()
    
    func getArticles(completion: ((Result<ArticleModel?, Error>) -> ())?) {
        let params = [
            "api-key": "QP5J5EfGIo2SulKxqdHNBS3LcmVPG5lo"
        ]
        
        Router<ArticleEndpointType>()
            .request(.articles(predicate: params), completion: { (response: Result<ArticleModel?, Error>) in
                switch response {
                case .success(let results):
                    completion?(.success(results))
                case .failure(let error):
                    completion?(.failure(error))
                }
            })
    }
}
