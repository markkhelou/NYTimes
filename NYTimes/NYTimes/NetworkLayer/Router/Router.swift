//
//  Router.swift
//  ShopifyInternApp
//
//  Created by Rinni Swift on 3/17/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation

enum Router {
    
    private static var baseURL = "api.nytimes.com"
    private static var apiKey = "QP5J5EfGIo2SulKxqdHNBS3LcmVPG5lo"
    
    case getArticles(period: String)
    
    var scheme: String {
        switch self {
        case .getArticles:
            return "http"
        }
    }
    
    var host: String {
        switch self {
        case .getArticles:
            return Router.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .getArticles(let period):
            return "/svc/mostpopular/v2/viewed/\(period).json"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getArticles: return [URLQueryItem(name: "api-key",
                                                value: Router.apiKey)]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getArticles: return .get
        }
    }
}
