//
//  NetworkError.swift
//  NYTimes
//
//  Created by marc helou on 2/23/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError, Error {
    case unknown
    case wrongURLFormat
    case error(String)
    case notCodable
    
    public var errorDescription: String? {
        switch self {
        case .unknown: return NSLocalizedString("networkError.unknown", comment: "")
        case .wrongURLFormat: return NSLocalizedString("error.wrongURLFormat", comment: "")
        case .error(let message): return message
        case .notCodable: return NSLocalizedString("error.notCodable", comment: "")
        }
    }
}

struct ServerError: Codable {
    var fault: ServerFaultError
}

struct ServerFaultError: Codable {
    var faultstring: String
}
