//
//  Endpoints.swift
//  APILayerProj
//
//  Created by marc helou on 2/19/21.
//

import Foundation

protocol Endpoint {
    static var baseURL: String { get }
    static func path(_ path: String) -> String
}

extension Endpoint {
    static func configuration(for key: String) -> String { (Bundle.main.object(forInfoDictionaryKey: key) as? String) ?? "" }
    static var baseURL: String { configuration(for: ApiConstants.baseUrl) }
    static func path(_ path: String) -> String {  baseURL + path }
}
